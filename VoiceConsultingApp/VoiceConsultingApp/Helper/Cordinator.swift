//
//  Cordinator.swift
//  PersonalScheduler
//
//  Created by 정재근 on 2023/01/09.
//

import UIKit

class Cordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        
        self.window = window
    }
    
    func start() {
        
        checkAppData()
        isHiddenNavigationBar()
        window.makeKeyAndVisible()
    }
    
    func checkAppData() {
        
        if FirebaseAuthManager.shared.getUserUid() != nil { // FirebaseAuth CurrentUser(UserUid) Check
            
            if CheckDataManager.shared.getIsInputInfo() != nil { // Checking input userData
                
                Config.isUser = CheckDataManager.shared.getIsUser() // 글로벌 데이터에 유저 타입 넣기
                Config.name = CheckDataManager.shared.getName() // 글로벌 데이터에 이름 넣기
                window.rootViewController = UINavigationController(rootViewController: CustomTabBarController())
            }
        } else {
            
            window.rootViewController = UINavigationController(rootViewController: LoginVC())
        }
    }
    
    func isHiddenNavigationBar() {
        
        window.rootViewController?.navigationController?.navigationBar.isHidden = true
    }
}
