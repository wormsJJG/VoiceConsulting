//
//  MorePopularVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import RxSwift
import RxCocoa

class MorePopularVC: BaseViewController {
    // MARK: - Load View
    private let morePopularV = MorePopularV()
    
    override func loadView() {
        self.view = morePopularV
    }
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel = MorePopularVM()

    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAction()
        dataBind()
    }
    // MARK: - data bind
    private func dataBind() {
        self.viewModel.output.popularCounselorList
            .bind(to: morePopularV.counselorList.rx.items(cellIdentifier: MorePopularCell.cellID, cellType: MorePopularCell.self)) { index, counselor, cell in
                
                cell.configureCell(in: counselor.info)
            }
            .disposed(by: self.disposeBag)
    }
    // MARK: - AddAction
    private func addAction() {
        
        self.morePopularV.headerView.backButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.popVC()
            })
            .disposed(by: self.disposeBag)
    }
}
