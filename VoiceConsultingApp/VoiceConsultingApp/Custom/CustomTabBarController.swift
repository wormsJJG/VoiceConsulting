//
//  CustomTabBarController.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import AgoraChat
import RxSwift

class CustomTabBarController: UITabBarController {
    
    private let disposeBag = DisposeBag()
    
    deinit {
        
        unregisterNotifications()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        registerNotifications()
    }
}

extension CustomTabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        isHiddenNavigationBar()
        let main = UINavigationController(rootViewController: MainVC())
        let chattingList = UINavigationController(rootViewController: ChattingListVC())
        let myPage = UINavigationController(rootViewController: MyPageVC())
        
        self.setViewControllers([main, chattingList, myPage], animated: true)
        self.tabBar.selectedImageTintColor = ColorSet.mainColor
        self.tabBar.unselectedItemTintColor = ColorSet.subTextColor2
        
        if Config.isUser {
            self.selectedIndex = 0
        } else {
            self.selectedIndex = 2
        }
        
        if let items = self.tabBar.items {
            items[0].image = UIImage(named: AssetImage.mainIconFill)
            items[0].title = "메인"
            
            items[1].image = UIImage(named: AssetImage.chattingIconFill)
            items[1].title = "채팅"
            
            items[2].image = UIImage(named: AssetImage.myIconFill)
            items[2].title = "MY"
        }
    }
}

extension CustomTabBarController {
    
    func isHiddenBackButton() {
        
        self.navigationItem.hidesBackButton = true
    }
    
    func isHiddenNavigationBar() {
        
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension CustomTabBarController: AgoraChatManagerDelegate, AgoraChatClientDelegate {
    
    private func registerNotifications() {
        self.unregisterNotifications()
        AgoraChatClient.shared().add(self, delegateQueue: nil)
        AgoraChatClient.shared().chatManager?.add(self, delegateQueue: nil)
    }
    
    private func unregisterNotifications() {
        AgoraChatClient.shared().removeDelegate(self)
        AgoraChatClient.shared().chatManager?.remove(self)
    }
    
    func messagesDidReceive(_ aMessages: [AgoraChatMessage]) {
        
        for message in aMessages {
            
            convertMessage(in: message, completion: { [weak self] optionalMessage in
                
                guard let convertMessage = optionalMessage else { return }
                
                let state = UIApplication.shared.applicationState
                switch state {
                    
                case .inactive, .active:
                    
                    self?.didReceiveMessageForeground(message: convertMessage)
                case .background:
                    
                    self?.didReceiveMessageBackground(message: convertMessage)
                default:
                    
                    break
                }
            })
        }
    }
    
    private func didReceiveMessageForeground(message: Message) {
        
        if let didEnterChatRoomUid = MessageClient.shared.didEnterChatRoomUid { // 유저가 채팅방에 들어가있는가?
            
            if message.sender.senderId == didEnterChatRoomUid { // 유저가 들어간 채팅방 uid와 보낸사람의 uid가 같은가?
                    
                MessageStorage.shared.saveMessage(by: message.sender.senderId, message: message.toRealmMessage())
                MessageClient.shared.delegate?.didReceiveMessage(message: message)
                
                return
            }
        }
        
        if ChatChannelStorage.shared.isExistChannel(by: message.sender.senderId) { // 저장된 챗 채널이 있는가?
            
            MessageStorage.shared.saveMessage(by: message.sender.senderId, message: message.toRealmMessage())
            ChatChannelStorage.shared.editUnReadMessageCount(uid: message.sender.senderId, count: 1, isIncrease: true)
            ChattingListClient.shared.delegate?.didReceiveMessage(message)
            showLocalNotification(in: message)
            
            return
        } else { // 없다
            
            let chatChannel = ChatChannel()
            chatChannel.name = message.sender.displayName
            chatChannel.uid = message.sender.senderId
            chatChannel.lastMessage = message.toRealmMessage()
            
            fetchProfileImageUrlString(to: message.sender.senderId, completion: { profileImageUrlString in
                
                chatChannel.profileUrlString = profileImageUrlString
                ChatChannelStorage.shared.addChatChannel(chatChannel: chatChannel)
                ChatChannelStorage.shared.editUnReadMessageCount(uid: message.sender.senderId, count: 1, isIncrease: true)
                ChattingListClient.shared.delegate?.didReceiveMessage(message)
                self.showLocalNotification(in: message)
            })
        }
    }
    
    private func didReceiveMessageBackground(message: Message) {
        
        if ChatChannelStorage.shared.isExistChannel(by: message.sender.senderId) { // 저장된 챗 채널이 있는가?
            
            MessageStorage.shared.saveMessage(by: message.sender.senderId, message: message.toRealmMessage())
        } else { // 없다
            
            let chatChannel = ChatChannel()
            chatChannel.name = message.sender.displayName
            chatChannel.uid = message.sender.senderId
            chatChannel.lastMessage = message.toRealmMessage()
            
            fetchProfileImageUrlString(to: message.sender.senderId, completion: { profileImageUrlString in
                
                chatChannel.profileUrlString = profileImageUrlString
                ChatChannelStorage.shared.addChatChannel(chatChannel: chatChannel)
            })
        }
        
        showLocalNotification(in: message)
    }
    
    private func convertMessage(in agoraMessage: AgoraChatMessage, completion: @escaping ((Message?) -> Void)) {

        do {
            
            guard let ext = agoraMessage.ext,
                  let apnsItem = ext["em_apns_ext"],
                  let convertApns = apnsItem as? [String: Any],
                  let senderName = convertApns["senderName"] as? String,
                  let message = convertApns["message"] as? String,
                  let data = getMessageBodyString(body: agoraMessage.swiftBody).data(using: .utf8) else { return }
            let convertMessage = try JSONDecoder().decode(TextMessage.self, from: data)
            let sender = Sender(senderId: agoraMessage.from, displayName: senderName)
            var messageType: Message?

            switch convertMessage.typeMessage {

            case 0:

                messageType = Message(content: convertMessage.message,
                                  sender: sender,
                                  sentDate: Date(),
                                  messageId: nil)
            case 1:

                messageType = Message(imageUrlString: convertMessage.message,
                                  sender: sender,
                                  sentDate: Date(),
                                  messageId: nil)
            default:

                break
            }
            
            completion(messageType)
        } catch {

            completion(nil)
        }
    }
    
    private func getMessageBodyString(body: AgoraChatMessageBaseBody) -> String {
        
        switch body {
            
        case let .text(content):
            
            return content
        default:
            
            return ""
        }
    }
    
    private func fetchProfileImageUrlString(to: String, completion: @escaping ((String) -> Void)) {
        
        if !Config.isUser { // 이 핸드폰의 사용자가 상담사라면
            
            fetchUserProfileUrlString(uid: to, completion: { profileImageUrlString in
                
                
                completion(profileImageUrlString)
            })
        } else {
            
            fetchCounselorProfileUrlString(uid: to, completion: { profileImageUrlString in
                
                completion(profileImageUrlString)
            })
        }
    }
    
    private func fetchCounselorProfileUrlString(uid: String, completion: @escaping((String) -> Void)) {
        
        CounselorManager.shared.getCounselor(in: uid)
            .map { $0.info.profileImageUrl }
            .subscribe(onNext: { [weak self] profileImageUrlString in
                
                completion(profileImageUrlString)
            }, onError: { error in
                
                completion("")
            })
            .disposed(by: self.disposeBag)
    }
    
    private func fetchUserProfileUrlString(uid: String, completion: @escaping((String) -> Void)) {
        
        UserManager.shared.fetchUserData(in: uid)
            .map { $0.profileImageUrl ?? "" }
            .subscribe(onNext: { [weak self] profileImageUrlString in
                
                completion(profileImageUrlString)
            }, onError: { error in
                
                completion("")
            })
            .disposed(by: self.disposeBag)
    }
    
    private func addChatChannelAndMessageRoom(in chatChannel: ChatChannel) {
        
        ChatChannelStorage.shared.addChatChannel(chatChannel: chatChannel)
    }
    
    private func showLocalNotification(in message: Message) {
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = message.sender.displayName
        content.body = message.content
        
        let request = UNNotificationRequest(identifier: "agoraChat", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}


