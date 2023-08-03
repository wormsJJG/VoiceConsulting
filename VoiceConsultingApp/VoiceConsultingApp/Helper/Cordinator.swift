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
        
        window.rootViewController = UINavigationController(rootViewController: SplashVC())
        window.makeKeyAndVisible()
    }
}
