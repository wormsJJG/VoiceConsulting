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
    private let headerview = ChatRoomHeader()
    
    lazy var plusButtonItem: InputBarButtonItem = InputBarButtonItem().then {
        $0.setImage(UIImage(named: AssetImage.plus), for: .normal)
    }
    
    let channel: ChatChannel = ChatChannel(name: "김이름 상담사")
    var sender = Sender(senderId: "any_unique_id", displayName: "jake")
    var messages = [Message]()
    private let disposeBag = DisposeBag()
    private lazy var customMessagesSizeCalculator = RequestTranscationSizeCalculator(layout: self.messagesCollectionView.messagesCollectionViewFlowLayout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        constraints()
        setMessageCollectionView()
        inputBarDesign()
        addAction()
        AgoraChatClient.shared.chatManager?.add(self, delegateQueue: nil)
        messagesCollectionView.register(RequestTransactionCell.self)
    }
    func messagesDidReceive(_ aMessages: [AgoraChatMessage]) {
        for msg in aMessages {
                    switch msg.swiftBody {
                    case let .text(content):
                        print(msg.from)
                        var message = Message(content: content, sender: Sender(senderId: "asdasd", displayName: "asdasd"))
                        message.custom = "asdasd"
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
        
        messageInputBar.delegate = self
    }
    
    private func constraints() {
        self.view.addSubview(headerview)
        
        self.headerview.snp.makeConstraints {
            $0.left.equalTo(self.messagesCollectionView.snp.left)
            $0.top.equalTo(self.messagesCollectionView.snp.top)
            $0.right.equalTo(self.messagesCollectionView.snp.right)
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
        let cell = messagesCollectionView.dequeueReusableCell(RequestTransactionCell.self, for: indexPath)
        cell.configure(with: message, at: indexPath, in: messagesCollectionView, dataSource: self, and: customMessagesSizeCalculator)
        
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
        customMessagesSizeCalculator
    }
}
// MARK: - MessagesDisplayDelegate
extension ChatRoomVC: MessagesDisplayDelegate {
    private func setMessageCollectionView() {
        self.messagesCollectionView.backgroundColor = ColorSet.chatRoomBack
        additionalSafeAreaInsets = UIEdgeInsets(top: 54 + 20, left: 0, bottom: 0, right: 0)
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
}
// MARK: - InputBarAccessoryViewDelegate
extension ChatRoomVC: InputBarAccessoryViewDelegate {
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
        let message = Message(content: text, sender: Sender(senderId: "any_unique_id", displayName: "jake"))
            
        sendMessage(message: message)
        inputBar.inputTextView.text.removeAll()
    }
    
    private func sendMessage(message: Message) {
        let msg = AgoraChatMessage(
            conversationId: "test", from: AgoraChatClient.shared.currentUsername!,
            to: "testAdmin", body: .text(content: message.content), ext: nil
                )
        AgoraChatClient.shared.chatManager?.send(msg, progress: nil)
        messages.append(message)
        messages.sort()
        
        messagesCollectionView.reloadData()
    }
}
