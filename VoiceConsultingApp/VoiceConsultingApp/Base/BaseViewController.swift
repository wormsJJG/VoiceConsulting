//
//  BaseViewController.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/22.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        isHiddenNavigationBar()
    }
    
    func isHiddenBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func isHiddenNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func moveCoinManagementVC() {
        let coinManagementVC = CoinManagementVC()
        coinManagementVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(coinManagementVC, animated: true)
    }
    
    func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func moveChatRommVC() {
        let chatRoom = ChatRoomVC()
        chatRoom.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(chatRoom, animated: true)
    }
    
    func moveAlertVC() {
        let alertVC = AlertVC()
        alertVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(alertVC, animated: true)
    }
}
