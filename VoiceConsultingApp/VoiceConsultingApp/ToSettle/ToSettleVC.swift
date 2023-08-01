//
//  ToSettleVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/01.
//

import UIKit
import RxSwift
import RxCocoa

class ToSettleVC: BaseViewController {
    
    // MARK: - Load View
    private let toSettleV = ToSettleV()
    
    override func loadView() {
        super.loadView()
        
        self.view = toSettleV
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
extension ToSettleVC {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    private func addAction() {
        
        toSettleV.header.backButton
            .rx
            .tap
            .bind(onNext: { [weak self] _ in
                
                self?.popVC()
            })
            .disposed(by: self.disposeBag)
    }
}