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
        let rootVC = LoginVC()
        let navigationRootVC = UINavigationController(rootViewController: rootVC)
        
        window.rootViewController = navigationRootVC
        window.makeKeyAndVisible()
    }
}
