//
//  RevenueManagementVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/28.
//

import UIKit
import RxSwift
import RxCocoa

class RevenueManagementVC: BaseViewController {

    // MARK: - Load View
    private let revenueManagementV = RevenueManagementV()
    
    override func loadView() {
        super.loadView()
        
        self.view = revenueManagementV
    }
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        addAction()
        addChildVC()
    }
}
// MARK: - ContainerViewSetting
extension RevenueManagementVC {
    
    private func addChildVC() {
        
        let tabmanVC = RevenuePageBoyVC()
        tabmanVC.view.frame = CGRect(x: 0,
                                     y: 0,
                                     width: revenueManagementV.containerView.frame.width,
                                     height: revenueManagementV.containerView.frame.height)
        self.addChild(tabmanVC)
        self.revenueManagementV.containerView.addSubview(tabmanVC.view)
        tabmanVC.didMove(toParent: self)
    }
}
// MARK: - Add Action
extension RevenueManagementVC {
    
    private func addAction() {
        
        revenueManagementV.header.backButton
            .rx
            .tap
            .bind(onNext: { [weak self] _ in
                
                self?.popVC()
            })
            .disposed(by: self.disposeBag)
        
        revenueManagementV.moveToSettleVCButton
            .rx
            .tap
            .bind(onNext: { [weak self] _ in
                
                self?.moveToSettleVC()
            })
            .disposed(by: self.disposeBag)
        
    }
}
