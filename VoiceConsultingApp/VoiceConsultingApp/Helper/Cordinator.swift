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

        if FirebaseAuthManager.shared.isLogin {
            
            window.rootViewController = CustomTabBarController()
        } else {
            
            let loginVC = UINavigationController(rootViewController: LoginVC())
            window.rootViewController = loginVC
        }
        
        window.makeKeyAndVisible()
    }
}
