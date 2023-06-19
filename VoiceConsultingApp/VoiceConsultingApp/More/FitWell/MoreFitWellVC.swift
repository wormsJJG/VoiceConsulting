//
//  MoreFitWellVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import RxSwift
import RxCocoa

class MoreFitWellVC: BaseViewController {
    // MARK: - Load View
    private let moreFitWellV = MoreFitWellV()
    
    override func loadView() {
        self.view = moreFitWellV
    }
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel = MoreFitWellVM()
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAction()
        dataBind()
    }
    // MARK: - data bind
    private func dataBind() {
        self.viewModel.output.fitWellCounselorList
            .bind(to: moreFitWellV.counselorList.rx.items(cellIdentifier: MoreFitWellCell.cellID, cellType: MoreFitWellCell.self)) { index, counselor, cell in
                
                cell.configureCell(in: counselor.info)
            }
            .disposed(by: self.disposeBag)
    }
    // MARK: - AddAction
    private func addAction() {
        
        self.moreFitWellV.headerView.backButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.popVC()
            })
            .disposed(by: self.disposeBag)
    }
}
