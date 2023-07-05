//
//  ChatRoomVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/17.
//

import UIKit
import MessageKit
import InputBarAccessoryView
import RxCocoa
import RxSwift
import SnapKit
import Then
import AgoraChat

class ChatRoomVC: MessagesViewController, AgoraChatManagerDelegate {
    // MARK: - View Components
    private let headerview = ChatRoomHeader().then {
        
        $0.coinBlock.isHidden = !Config.isUser
        $0.heartButton.isHidden = !Config.isUser
    }
    private let customInputView = CustomInputView()
    private let requestView = RequestPaymentView().then {
        
        $0.isHidden = Config.isUser
    }
    
    lazy var plusButtonItem: InputBarButtonItem = InputBarButtonItem().then {
        $0.setImage(UIImage(named: AssetImage.plus), for: .normal)
        $0.addTarget(self, action: #selector(didTapPlusButtonItem), for: .touchUpInside)
    }
    
    // MARK: - Properties
    var isCustomInputView: Bool = false
    let channel: ChatChannel = ChatChannel(name: "김이름 상담사")
    var sender = Sender(senderId: "any_unique_id", displayName: "jake")
    var messages = [Message]()
    private let disposeBag = DisposeBag()
    
    // MARK: - SizeCalcurator
    private lazy var requestTranscationSizeCalculator = RequestTranscationSizeCalculator(layout: self.messagesCollectionView.messagesCollectionViewFlowLayout)
    private lazy var customTextMessagesSizeCalculator = CustomTextLayoutSizeCalculator(layout: self.messagesCollectionView.messagesCollectionViewFlowLayout)
    private lazy var transcationCompletedSizeCalculator = TransactionCompletedSizeCalculator(layout: self.messagesCollectionView.messagesCollectionViewFlowLayout)
    private lazy var endConsultationSizeCalculator = EndConsultationSizeCalculator(layout: self.messagesCollectionView.messagesCollectionViewFlowLayout)
    
// MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        constraints()
        setMessageCollectionView()
        inputBarDesign()
        addAction()
    }
    
    func messagesDidReceive(_ aMessages: [AgoraChatMessage]) {
        for msg in aMessages {
            print(msg.swiftBody)
            switch msg.swiftBody {
            case let .text(content):
                print(msg.from)
                var message = Message(content: content, sender: Sender(senderId: "asdasd", displayName: "asdasd"))
                messages.append(message)
                self.messagesCollectionView.reloadData()
            default:
                break
            }
        }
    }
    
    private func setDelegates() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        AgoraChatClient.shared.chatManager?.add(self, delegateQueue: nil)
        messageInputBar.delegate = self
        headerview.heartButton.delegate = self
        customInputView.delegate = self
    }
    
    private func constraints() {
        self.view.addSubview(headerview)
        
        self.headerview.snp.makeConstraints {
            $0.left.equalTo(self.view.snp.left)
            $0.top.equalTo(self.view.snp.top)
            $0.right.equalTo(self.view.snp.right)
        }
        
        self.view.addSubview(requestView)
        
        requestView.snp.makeConstraints {
            $0.height.equalTo(66)
            $0.left.equalTo(self.view.snp.left)
            $0.top.equalTo(self.headerview.snp.bottom)
            $0.right.equalTo(self.view.snp.right)
        }
    }
    
    private func addAction() {
        headerview.backButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: self.disposeBag)
    }
}
// MARK: - didTapHeartButton
extension ChatRoomVC: HeartButtonDelegate {
    func didTapHeartButton(didTap: Bool) {
        print(didTap)
    }
}

// MARK: - MessagesDataSource
extension ChatRoomVC: MessagesDataSource {
    var currentSender: MessageKit.SenderType {
        return self.sender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        return messages.count
    }
    
    func customCell(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UICollectionViewCell {
        if let msg = message as? Message {
            switch msg.systemMessage! {
            case .requestTranscation:
                let cell = messagesCollectionView.dequeueReusableCell(RequestTransactionCell.self, for: indexPath)
                cell.configure(with: message, at: indexPath, in: messagesCollectionView, dataSource: self, and: requestTranscationSizeCalculator)
                
                return cell
            case .transactionCompleted:
                let cell = messagesCollectionView.dequeueReusableCell(TransactionCompletedCell.self, for: indexPath)
                cell.configure(with: message, at: indexPath, in: messagesCollectionView, dataSource: self, and: transcationCompletedSizeCalculator)
                
                return cell
            case .endConsultation:
                let cell = messagesCollectionView.dequeueReusableCell(EndConsultationCell.self, for: indexPath)
                cell.configure(with: message, at: indexPath, in: messagesCollectionView, dataSource: self, and: endConsultationSizeCalculator)
                cell.systemMessageDelegate = self

                
                return cell
            }
        }
        return UICollectionViewCell()
    }

    func textCell(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UICollectionViewCell? {
        let cell = messagesCollectionView.dequeueReusableCell(
          CustomTextMessageCell.self,
          for: indexPath)
        cell.configure(
          with: message,
          at: indexPath,
          in: messagesCollectionView,
          dataSource: self,
          and: customTextMessagesSizeCalculator)

        return cell
    }
}

// MARK: - MessagesLayoutDelegate
extension ChatRoomVC: MessagesLayoutDelegate {
    // 아래 여백
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        
        return CGSize(width: 0, height: 10)
    }
        
    // 말풍선 위 이름 나오는 곳의 height
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return isFromCurrentSender(message: message) ? 0 : 0
    }
    
    func customCellSizeCalculator(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator {
        if let msg = message as? Message {
            switch msg.systemMessage! {
            case .requestTranscation:
                return requestTranscationSizeCalculator
            case .transactionCompleted:
                return transcationCompletedSizeCalculator
            case .endConsultation:
                return endConsultationSizeCalculator
            }
        }
        return customTextMessagesSizeCalculator
    }
    
    func textCellSizeCalculator(
      for _: MessageType,
      at _: IndexPath,
      in _: MessagesCollectionView)
      -> CellSizeCalculator?
    {
      customTextMessagesSizeCalculator
    }
}
// MARK: - InputViewDelegate
extension ChatRoomVC: CustomInputViewDelegate {
    func didTapMenuButton(selectMenu: InputViewMenuType) {
        print(selectMenu)
    }
}
// MARK: - MessagesDisplayDelegate
extension ChatRoomVC: MessagesDisplayDelegate {
    private func setMessageCollectionView() {
        self.messagesCollectionView.backgroundColor = ColorSet.chatRoomBack
        additionalSafeAreaInsets = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
        messagesCollectionView.register(RequestTransactionCell.self)
        messagesCollectionView.register(CustomTextMessageCell.self)
        messagesCollectionView.register(TransactionCompletedCell.self)
        messagesCollectionView.register(EndConsultationCell.self)
    }
    // 말풍선의 배경 색상
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? ColorSet.mainColor! : .white
    }
    // 글자색
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .white : ColorSet.mainText!
    }
        
    // 말풍선의 꼬리 모양 방향
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        
        return isFromCurrentSender(message: message) ? .custom({ messageView in
            let maskPath = UIBezierPath(roundedRect: messageView.bounds, byRoundingCorners: [.topLeft, .bottomLeft, .bottomRight], cornerRadii: CGSizeMake(10, 10))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = messageView.bounds
            maskLayer.path  = maskPath.cgPath
            messageView.layer.mask = maskLayer
        }) : .custom({ messageView in
            let maskPath = UIBezierPath(roundedRect: messageView.bounds, byRoundingCorners: [.topRight, .bottomLeft, .bottomRight], cornerRadii: CGSizeMake(10, 10))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = messageView.bounds
            maskLayer.path  = maskPath.cgPath
            messageView.layer.mask = maskLayer
        })
    }
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize? {
        if isFromCurrentSender(message: message) {
            return CGSize(width: 10, height: 10)
        } else {
            return CGSize(width: 40, height: 40)
        }
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        if isFromCurrentSender(message: message) {
            avatarView.backgroundColor = ColorSet.chatRoomBack
        }
    }
    
    func messageBottomLabelAttributedText(for message: MessageType, at _: IndexPath) -> NSAttributedString? {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm"
        formatter.locale = Locale(identifier: "ko_KR")
        let dateString = formatter.string(from: message.sentDate)
        return NSAttributedString(
        string: dateString,
        attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.NotoSansKR_Regular, size: 12)!])
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일 EEEE"
        formatter.locale = Locale(identifier: "ko_KR")
        let dateString = formatter.string(from: message.sentDate)
        let attributeString = NSAttributedString(string: dateString, attributes: [NSAttributedString.Key.font: UIFont(name: Fonts.NotoSansKR_Regular, size: 12)!])
        if messages.count == 1 {
            return attributeString
        } else {
            if Calendar.current.isDateInToday(messages[indexPath.row].sentDate) {
                return nil
            } else {
                return attributeString
            }
        }
    }
}
// MARK: - InputBarAccessoryViewDelegate
extension ChatRoomVC: InputBarAccessoryViewDelegate {
    
    @objc private func didTapPlusButtonItem() {
        
        DispatchQueue.main.async { [weak self] in
            
            if !self!.isCustomInputView {
                
                self?.messageInputBar.inputTextView.inputView = self?.customInputView
                self?.plusButtonItem.setImage(UIImage(named: AssetImage.cancelIcon), for: .normal)
            } else {
                self?.messageInputBar.inputTextView.inputView = nil
                self?.plusButtonItem.setImage(UIImage(named: AssetImage.plus), for: .normal)
            }
            
            self?.messageInputBar.inputTextView.reloadInputViews()
            self?.messageInputBar.inputTextView.becomeFirstResponder()
            
            self?.isCustomInputView = !self!.isCustomInputView
        }
    }
    
    private func inputBarDesign() {
        messageInputBar.setRightStackViewWidthConstant(to: 40, animated: false)
        messageInputBar.rightStackView.alignment = .center
        messageInputBar.leftStackView.alignment = .center
        messageInputBar.setLeftStackViewWidthConstant(to: 40, animated: false)
        messageInputBar.setStackViewItems([plusButtonItem], forStack: .left, animated: false)
        messageInputBar.sendButton.setTitle(nil, for: .normal)
        messageInputBar.sendButton.setImage(UIImage(named: AssetImage.send), for: .normal)
        messageInputBar.inputTextView.layer.cornerRadius = 20
        messageInputBar.inputTextView.layer.borderWidth = 1
        messageInputBar.inputTextView.layer.borderColor = ColorSet.line?.cgColor
        messageInputBar.inputTextView.placeholder = "메세지를 입력하세요"
        messageInputBar.inputTextView.placeholderLabel.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 16)
        messageInputBar.inputTextView.placeholderTextColor = ColorSet.date
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        messageInputBar.inputTextView.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 16)
        messageInputBar.inputTextView.textColor = ColorSet.mainText
    }
    
    //send버튼을 눌렀을떄
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        var message = Message(content: text, sender: Sender(senderId: "any_unique_id", displayName: "jake"))
        
        if message.content == "거래 요청 메세지" {
            message.systemMessage = .requestTranscation
        } else if message.content == "거래 완료 메세지" {
            message.systemMessage = .transactionCompleted
        } else if message.content == "상담 종료 메세지" {
            message.systemMessage = .endConsultation
        }
        
        sendMessage(message: message)
        inputBar.inputTextView.text.removeAll()
    }
    
    private func sendMessage(message: Message) {
        let msg = AgoraChatMessage(
            conversationId: "test", from: AgoraChatClient.shared.currentUsername!,
            to: "worms0627", body: .text(content: message.content), ext: nil
                )
//        let message = Agora
        
        AgoraChatClient.shared.chatManager?.send(msg, progress: nil)
        messages.append(message)
        messages.sort()
        
        messagesCollectionView.reloadData()
    }
}

extension ChatRoomVC: MessageButtonTouchable {
    func didTapButton(_ systemMessageType: SystemMessageType) {
        switch systemMessageType {
        case .requestTranscation:
            print("거래 요청")
        case .transactionCompleted:
            print("결제 완료")
        case .endConsultation:
            self.messageInputBar.endEditing(true)
            self.moveWriteReviewVC()
        }
    }
    
    private func moveWriteReviewVC() {
        let writeReviewVC = WriteReviewVC()
        writeReviewVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(writeReviewVC, animated: true)
    }
}
