//
//  RevenueManagementVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/28.
//

import UIKit
import RxSwift
import RxCocoa
import Tabman

class RevenueManagementVC: TabmanViewController {

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
    }
}
// MARK: - Add Action
extension RevenueManagementVC {
    
    private func addAction() {
        
        revenueManagementV.header.backButton
            .rx
            .tap
            .bind(onNext: { [weak self] _ in
                
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: self.disposeBag)
    }
}
