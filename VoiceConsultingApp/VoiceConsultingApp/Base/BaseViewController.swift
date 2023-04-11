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
    
    func didTapCoinBlock() {
        let coinManagementVC = CoinManagementVC()
        coinManagementVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(coinManagementVC, animated: true)
    }
    
    func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
}
