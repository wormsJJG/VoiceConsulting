//
//  HeartCounselorVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/22.
//

import UIKit
import RxSwift
import RxCocoa

class HeartCounselorVC: BaseViewController {
    // MARK: - load View
    private let heartCounselorV = HeartCounselorV()
    
    override func loadView() {
        super.loadView()
        self.view = heartCounselorV
    }
    // MARK: - Properties
    private let viewModel = HeartCounselorVM()
    private let disposeBag = DisposeBag()
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        addAction()
        bindList()
    }
}
// MARK: - addAction
extension HeartCounselorVC {
    
    private func addAction() {
        
        self.heartCounselorV.headerView.backButton.rx.tap
            .bind(onNext: { [weak self] _ in
                
                self?.popVC()
            })
            .disposed(by: self.disposeBag)
    }
}
// MARK: - bindList
extension HeartCounselorVC {
    
    private func bindList() {
        
        self.viewModel.output.counselorList
            .filter { $0.count == 0 }
            .bind(onNext: { [weak self] _ in

                self?.heartCounselorV.emptyLabel.isHidden = false
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.counselorList
            .bind(to: self.heartCounselorV.counselorList.rx.items(cellIdentifier: HeartCounselorCell.cellID, cellType: HeartCounselorCell.self)) { index, counselor, cell in
                
            cell.heartButton.delegate = self
        }
        .disposed(by: self.disposeBag)
    }
}
 // MARK: - didTapHeartButton
extension HeartCounselorVC: HeartButtonDelegate {
    
    func didTapHeartButton(didTap: Bool) {
        
        print(didTap)
    }
}
