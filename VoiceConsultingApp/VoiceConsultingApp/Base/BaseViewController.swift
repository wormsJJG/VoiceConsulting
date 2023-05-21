//
//  BaseViewController.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/22.
//

import UIKit
import AcknowList

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
    
    func moveOpenSourceLicense(){
        let acknowList = AcknowListViewController(fileNamed: "Pods-VoiceConsultingApp-acknowledgements")
        // 오픈소스 라이선스 VC 이동할떄 네비게이션바가 없으면 돌아올 방법이 없어서 네비게이션 바의 hidden을 false 한다.
        self.navigationController?.navigationBar.isHidden = false
        acknowList.hidesBottomBarWhenPushed = true
        acknowList.title = "오픈소스 라이브러리"
        navigationController?.pushViewController(acknowList, animated: true)
    }
}
