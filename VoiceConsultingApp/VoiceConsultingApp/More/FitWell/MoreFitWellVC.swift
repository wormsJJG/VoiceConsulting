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
    let liveCounselorList: PublishSubject<[String]> = PublishSubject()
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moreFitWellV.headerView.backButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: self.disposeBag)
        dataBind()
        liveCounselorList.onNext(["", "", "", "", "", "", "", "", "", ""])
    }
    // MARK: - data bind
    private func dataBind() {
        self.liveCounselorList
            .bind(to: moreFitWellV.counselorList.rx.items(cellIdentifier: MoreFitWellCell.cellID, cellType: MoreFitWellCell.self)) { index, counselor, cell in

            }
            .disposed(by: self.disposeBag)
    }
}
