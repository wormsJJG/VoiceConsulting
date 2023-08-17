//
//  CustomTabBarController.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import AgoraChat

class CustomTabBarController: UITabBarController {
    
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
            
            let state = UIApplication.shared.applicationState
            switch state {
                
            case .inactive, .active:
                
                showLocalNotification(in: message)
            case .background:
                
                showLocalNotification(in: message)
            default:
                
                break
            }
        }
    }
    
    private func showLocalNotification(in message: AgoraChatMessage) {
        
        guard let ext = message.ext,
              let apnsItem = ext["em_apns_ext"],
              let convertApns = apnsItem as? [String: Any],
              let senderName = convertApns["senderName"] as? String,
              let message = convertApns["message"] as? String else { return }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.01, repeats: false)
        let content = UNMutableNotificationContent()
        content.title = senderName
        content.body = message
        
        let request = UNNotificationRequest(identifier: "agoraChat", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}


