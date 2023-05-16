//
//  CustomTabBarController.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit

class CustomTabBarController: UITabBarController {
    var defaultIndex = 0 {
        didSet {
            self.selectedIndex = defaultIndex
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.selectedIndex = defaultIndex
    }
}

extension CustomTabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let main = UINavigationController(rootViewController: MainVC())
        let chattingList = UINavigationController(rootViewController: ChattingListVC())
        let myPage = UINavigationController(rootViewController: MyPageVC())
        
        self.setViewControllers([main, chattingList, myPage], animated: true)
        self.tabBar.selectedImageTintColor = ColorSet.mainColor
        self.tabBar.unselectedItemTintColor = ColorSet.subTextColor2
        
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
