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
import RealmSwift
import Kingfisher

class ChatRoomVC: MessagesViewController {
    // MARK: - View Components
    private let headerView = ChatRoomHeader().then {
        
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
    
    private lazy var refreshControl: UIRefreshControl = UIRefreshControl().then {
        
        $0.tintColor = ColorSet.mainColor
    }
    
    // MARK: - Properties
    
    private let viewModel = ChatRoomVM()
    private let disposeBag = DisposeBag()
    
    // MARK: - SizeCalcurator
    private lazy var requestTranscationSizeCalculator = RequestTranscationSizeCalculator(layout: self.messagesCollectionView.messagesCollectionViewFlowLayout)
    private lazy var customTextMessagesSizeCalculator = CustomTextLayoutSizeCalculator(layout: self.messagesCollectionView.messagesCollectionViewFlowLayout)
    private lazy var transcationCompletedSizeCalculator = TransactionCompletedSizeCalculator(layout: self.messagesCollectionView.messagesCollectionViewFlowLayout)
    private lazy var endConsultationSizeCalculator = EndConsultationSizeCalculator(layout: self.messagesCollectionView.messagesCollectionViewFlowLayout)
    private lazy var customImageMessagesSizeCalculator = CustomImageLayoutSizeCalculator(layout: self.messagesCollectionView.messagesCollectionViewFlowLayout)
    
// MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputSubscribe()
        setDelegates()
        constraints()
        setMessageCollectionView()
        inputBarDesign()
        addAction()
        viewModel.input.viewDidLoadTrigger.onNext(viewModel.channel!.uid)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MessageClient.shared.didEnterChatRoom(uid: viewModel.channel?.uid)
        bindData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        MessageClient.shared.didLeaveChatRoom()
    }
    
    deinit {
        
        MessageClient.shared.delegate = nil
    }
}
// MARK: - Output Subscribe
extension ChatRoomVC {
    
    private func outputSubscribe() {
        
        viewModel.output.reloadTrigger
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                
                self?.messagesCollectionView.reloadDataAndKeepOffset()
                self?.messagesCollectionView.scrollToLastItem()
            })
            .disposed(by: self.disposeBag)
        
        viewModel.output.errorTrigger
            .subscribe(onNext: { [weak self] error in
                
                self?.showErrorPopUp(errorString: error.localizedDescription)
            })
            .disposed(by: self.disposeBag)
        
        viewModel.output.isSuccessTranscation
            .subscribe(onNext: { [weak self] isSuccess in
                
                if isSuccess {
                    
                    self?.sendTransactionCompletedMessage()
                } else {
                    
                    DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
                        
                        self?.showLackCoinPopUp()
                    }
                }
            })
            .disposed(by: self.disposeBag)
    }
}
// MARK: - Helper
extension ChatRoomVC {
    
    func setChatChannel(_ chatChannel: ChatChannel) {
        
        self.viewModel.channel = chatChannel
        DispatchQueue.main.async { [weak self] in
            
            self?.headerView.counselorLabel.text = chatChannel.name
        }
    }
}

// MARK: - MessageClientDelegate
extension ChatRoomVC: MessageReceiveable {
    
    func didReceiveMessage(message: Message) { //메세지가 오면 호출
        
        viewModel.input.saveMessageInRealm.onNext(message)
    }
}
// MARK: - setDelegates
extension ChatRoomVC {
    
    private func setDelegates() {
        
        MessageClient.shared.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        AgoraChatClient.shared.chatManager?.add(self, delegateQueue: nil)
        messageInputBar.delegate = self
        headerView.heartButton.delegate = self
        customInputView.delegate = self
    }
}
// MARK: - addAction
extension ChatRoomVC {
    
    private func addAction() {
        
        headerView.backButton.rx.tap
            .bind(onNext: { [weak self] _ in
                
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: self.disposeBag)
        
        requestView.requestButton.rx.tap
            .bind(onNext: { [weak self] _ in
                
                self?.sendRequestTranscationMessage()
            })
            .disposed(by: self.disposeBag)
    }
}
// MARK: - Send Function
extension ChatRoomVC {
    
    //send버튼을 눌렀을떄
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        let message = Message(content: text, sender: self.currentSender(), sentDate: Date(), messageId: nil)
        
        sendTextMessage(message: message)
        inputBar.inputTextView.text.removeAll()
    }
    
    private func sendTextMessage(message: Message) {
        
        sendAgoraChat(message: message)
    }
    
    private func sendImageMessage(image: UIImage?) {
        
        FireStorageService.shared.uploadChattingImage(in: image)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .subscribe(onNext: { [weak self] imageUrlString in
                
                let message = Message(imageUrlString: imageUrlString,
                                      sender: self!.currentSender(),
                                      sentDate: Date(),
                                      messageId: nil)
                
                self?.sendAgoraChat(message: message)
            }, onError: { [weak self] error in
                
                self?.showErrorPopUp(errorString: error.localizedDescription)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func sendRequestTranscationMessage() {
        
        let message = Message(systemMessageType: SystemMessageType.requestTranscation,
                              sender: self.currentSender(),
                              sentDate: Date(),
                              messageId: nil)
        
        sendAgoraChat(message: message)
    }
    
    private func sendTransactionCompletedMessage() {
        
        let message = Message(systemMessageType: SystemMessageType.transactionCompleted,
                              sender: self.currentSender(),
                              sentDate: Date(),
                              messageId: nil)
        
        sendAgoraChat(message: message)
    }
    
    private func sendEndConsultationMessage() {
        
        let message = Message(systemMessageType: SystemMessageType.endConsultation,
                              sender: self.currentSender(),
                              sentDate: Date(),
                              messageId: nil)
        
        sendAgoraChat(message: message)
    }
    
    private func sendAgoraChat(message: Message) {
        
        AgoraChatClient.shared
            .chatManager?
            .send(message.toAgoraChatMessage(to: viewModel.channel!.uid),
                  progress: nil) { [weak self] agoraMessage , error  in
            
            if let error {
                
                self?.showErrorPopUp(errorString: error.errorDescription)
            } else {
                
                self?.viewModel.input.saveMessageInRealm.onNext(message)
            }
        }
    }
}
// MARK: - MessageButtonTouchable
extension ChatRoomVC: MessageButtonTouchable {
    
    func didTapButton(_ systemMessageType: SystemMessageType) {
        
        switch systemMessageType {
            
        case .requestTranscation:
            
            self.messageInputBar.endEditing(true)
            didTapRequestTranscationButton()
        case .transactionCompleted:
            
            self.messageInputBar.endEditing(true)
            self.moveVoiceRoom()
        case .endConsultation:
            
            self.messageInputBar.endEditing(true)
            self.didTapReviewButton()
        default:
            
            return
        }
    }
    
    private func didTapRequestTranscationButton() {
        
        if Config.isUser {
            
            self.showAnswerTransactionPopUp()
        } else {
            
            let popUp = OneButtonNoActionPopUpVC()
            popUp.popUpContent = "상담사는 결제가 불가능합니다."
            showPopUp(popUp: popUp)
        }
    }
    
    private func didTapReviewButton() {
        
        if Config.isUser {
            
            self.moveWriteReviewVC()
        } else {
            
            let popUp = OneButtonNoActionPopUpVC()
            popUp.popUpContent = "상담사는 리뷰 작성이 불가능합니다."
            showPopUp(popUp: popUp)
        }
    }
}
// MARK: - didTapHeartButton
extension ChatRoomVC: HeartButtonDelegate {
    
    func didTapHeartButton(didTap: Bool) {
        
        print(didTap)
    }
}
// MARK: - bindData
extension ChatRoomVC {
    
    private func bindData() {
        
        DispatchQueue.main.async { [weak self] in
                
            self?.headerView.coinBlock.coinCount.text = String(Config.coin)
        }
    }
}
// MARK: - imagePicker
extension ChatRoomVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func presentImagePicker(isCamera: Bool) {
        
        let picker = UIImagePickerController()
        
        isCamera ? picker.sourceType == .photoLibrary : picker.sourceType == .camera
        picker.allowsEditing = true // 편집 가능
        picker.delegate = self
        
        self.present(picker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 사진을 선택하지않고 취소한 경우
        
        self.dismiss(animated: true) { [weak self] () in // 창 닫기
            
            self?.showPopUp(popUp: CancelImagePickPopUp())
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 사진을 선택한 경우
        
        self.dismiss(animated: true) { [weak self] () in // 창닫기
            
            let selectImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            
            self?.sendImageMessage(image: selectImage)
        }
    }
}
// MARK: - AgoraChatManagerDelegate
extension ChatRoomVC: AgoraChatManagerDelegate {
    
}
// MARK: - MessagesDataSource
extension ChatRoomVC: MessagesDataSource {
    
    func currentSender() -> MessageKit.SenderType {
        
        return self.viewModel.sender
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessageKit.MessagesCollectionView) -> MessageKit.MessageType {
        
        return viewModel.output.messageList[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessageKit.MessagesCollectionView) -> Int {
        
        return viewModel.output.messageList.count
    }
    
    func customCell(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UICollectionViewCell {
        if let msg = message as? Message {
            switch msg.systemMessageType {
            case .requestTranscation:
                
                let cell = messagesCollectionView.dequeueReusableCell(RequestTransactionCell.self, for: indexPath)
                
                cell.configure(with: message, at: indexPath, in: messagesCollectionView, dataSource: self, and: requestTranscationSizeCalculator)
                cell.systemMessageDelegate = self
                
                return cell
            case .transactionCompleted:
                
                let cell = messagesCollectionView.dequeueReusableCell(TransactionCompletedCell.self, for: indexPath)
                
                cell.configure(with: message, at: indexPath, in: messagesCollectionView, dataSource: self, and: transcationCompletedSizeCalculator)
                cell.systemMessageDelegate = self
                
                return cell
            case .endConsultation:
                
                let cell = messagesCollectionView.dequeueReusableCell(EndConsultationCell.self, for: indexPath)
                
                cell.configure(with: message, at: indexPath, in: messagesCollectionView, dataSource: self, and: endConsultationSizeCalculator)
                cell.systemMessageDelegate = self

                
                return cell
            default:
                
                return UICollectionViewCell()
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
    
    func photoCell(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UICollectionViewCell? {
        
        let cell = messagesCollectionView.dequeueReusableCell(CustomImageMessageCell.self, for: indexPath)
        
        cell.configure(with: message, at: indexPath, in: messagesCollectionView, dataSource: self, and: customImageMessagesSizeCalculator)
        
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
            
            switch msg.systemMessageType {
                
            case .requestTranscation:
                
                return requestTranscationSizeCalculator
            case .transactionCompleted:
                
                return transcationCompletedSizeCalculator
            case .endConsultation:
                
                return endConsultationSizeCalculator
            default:
                
                return CellSizeCalculator()
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
        
        let isCamera = selectMenu == .camera
        
        self.view.endEditing(true)
        self.presentImagePicker(isCamera: isCamera)
    }
}
// MARK: - InputBarAccessoryViewDelegate
extension ChatRoomVC: InputBarAccessoryViewDelegate {
    
    @objc private func didTapPlusButtonItem() {
        
        DispatchQueue.main.async { [weak self] in
            
            if !self!.viewModel.isCustomInputView {
                
                self?.messageInputBar.inputTextView.inputView = self?.customInputView
                self?.plusButtonItem.setImage(UIImage(named: AssetImage.cancelIcon), for: .normal)
            } else {
                self?.messageInputBar.inputTextView.inputView = nil
                self?.plusButtonItem.setImage(UIImage(named: AssetImage.plus), for: .normal)
            }
            
            self?.messageInputBar.inputTextView.reloadInputViews()
            self?.messageInputBar.inputTextView.becomeFirstResponder()
            
            self?.viewModel.isCustomInputView = !self!.viewModel.isCustomInputView
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
        messageInputBar.inputTextView.textContainerInset = .init(top: 10, left: 16, bottom: 10, right: 16)
        messageInputBar.inputTextView.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 16)
        messageInputBar.inputTextView.textColor = ColorSet.mainText
    }
}
// MARK: - MoveView Func
extension ChatRoomVC {
    
    private func moveWriteReviewVC() {
        
        let writeReviewVC = WriteReviewVC()
        writeReviewVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(writeReviewVC, animated: true)
    }
    
    private func moveVoiceRoom() {
        
        let voiceRoomVC = VoiceRoomVC()
        
        self.navigationController?.pushViewController(voiceRoomVC, animated: true)
    }
    
    private func showErrorPopUp(errorString: String?) {
        
        let errorPopUp = ErrorPopUp()
        errorPopUp.errorString = errorString
        
        errorPopUp.hidesBottomBarWhenPushed = true
        errorPopUp.modalPresentationStyle = .overFullScreen
        errorPopUp.modalTransitionStyle = .crossDissolve
        self.present(errorPopUp, animated: true, completion: nil)
    }
    
    private func showPopUp(popUp: PopUpVC) {
        
        popUp.hidesBottomBarWhenPushed = true
        popUp.modalPresentationStyle = .overFullScreen
        popUp.modalTransitionStyle = .crossDissolve
        self.present(popUp, animated: true, completion: nil)
    }
    
    private func showAnswerTransactionPopUp() {
        
        let popUp = AnswerPopUp()
        popUp.popUpTitle = "결제 요청을 수락하시겠습니까?"
        popUp.popUpContent = "수락하시면 보유 코인 100개가 차감됩니다."
        popUp.setCallBack(didTapOkButtonCallBack: { [weak self] in
            
            self?.viewModel.input.didTapTranscationButton.onNext(())
        })
        
        self.showPopUp(popUp: popUp)
    }
    
    private func showLackCoinPopUp() {
        
        let popUp = LackCoinPopUp()
        popUp.setCallBack(didTapOkButtonCallBack: { [weak self] in
            
            self?.moveCoinManagementVC()
        })
        
        self.showPopUp(popUp: popUp)
    }
    
    private func moveCoinManagementVC() {
        
        let coinManagementVC = CoinManagementVC()
        coinManagementVC.hidesBottomBarWhenPushed = true
        coinManagementVC.startIndex = 0
        
        self.navigationController?.pushViewController(coinManagementVC, animated: true)
    }
}
// MARK: - MessagesDisplayDelegate
extension ChatRoomVC: MessagesDisplayDelegate {
    
    private func setMessageCollectionView() {
        
        scrollsToLastItemOnKeyboardBeginsEditing = true // default false
        maintainPositionOnKeyboardFrameChanged = true // default false
        self.messagesCollectionView.backgroundColor = ColorSet.chatRoomBack
        additionalSafeAreaInsets = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
        messagesCollectionView.register(RequestTransactionCell.self)
        messagesCollectionView.register(CustomTextMessageCell.self)
        messagesCollectionView.register(TransactionCompletedCell.self)
        messagesCollectionView.register(EndConsultationCell.self)
        messagesCollectionView.register(CustomImageMessageCell.self)
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
        } else {
            
            avatarView.kf.setImage(with: URL(string: viewModel.channel!.profileUrlString))
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

        let messageDate = viewModel.output.messageList.filter { Int(message.sentDate.timeIntervalSince1970 / 60 / 60 / 24) == Int($0.sentDate.timeIntervalSince1970 / 60 / 60 / 24) }

        guard let msg = messageDate.first else { return nil }

        if msg.sentDate == message.sentDate {
            
            return attributeString
        }

        return nil
    }
}
// MARK: - Constraints
extension ChatRoomVC {
    
    private func constraints() {
        
        view.addSubview(headerView)
        
        headerView.snp.makeConstraints {
            
            $0.left.equalTo(self.view.snp.left)
            $0.top.equalTo(self.view.snp.top)
            $0.right.equalTo(self.view.snp.right)
        }
        
        view.addSubview(requestView)
        
        requestView.snp.makeConstraints {
            
            $0.height.equalTo(66)
            $0.left.equalTo(self.view.snp.left)
            $0.top.equalTo(self.headerView.snp.bottom)
            $0.right.equalTo(self.view.snp.right)
        }
    }
}
