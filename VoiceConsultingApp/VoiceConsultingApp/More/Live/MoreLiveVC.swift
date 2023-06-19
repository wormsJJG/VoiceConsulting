//
//  MoreLiveVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import RxCocoa
import RxSwift

class MoreLiveVC: BaseViewController {
    // MARK: - Load View
    private let moreLiveV = MoreLiveV()
    
    override func loadView() {
        self.view = moreLiveV
    }
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel = MoreLiveVM()
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAction()
        dataBind()
    }
    // MARK: - dataBind
    private func dataBind() {
        self.viewModel.output.onlineCounselorList
            .bind(to: moreLiveV.counselorList.rx.items(cellIdentifier: LiveCounselorCell.cellID, cellType: LiveCounselorCell.self)) { index, counselor, cell in
                
                cell.configureCell(in: counselor.info)
            }
            .disposed(by: self.disposeBag)
    }
    // MARK: - AddAction
    private func addAction() {
        
        self.moreLiveV.headerView.backButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.popVC()
            })
            .disposed(by: self.disposeBag)
    }
}
