//
//  AlertVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/21.
//

import UIKit
import RxSwift
import RxCocoa

class AlertVC: BaseViewController {
    // MARK: - load View
    private let alertV = AlertV()
    
    override func loadView() {
        super.loadView()
        self.view = alertV
    }
    // MARK: - Properties
    let alertList: PublishSubject<[String]> = PublishSubject()
    private let disposeBag = DisposeBag()
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alertV.headerView.backButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.popVC()
            })
            .disposed(by: self.disposeBag)
        bindList()
        alertList.onNext(["", "", "", "", "", "", "", "", ""])
    }
}
// MARK: - bindList
extension AlertVC {
    
    private func bindList() {
        self.alertList.bind(to: self.alertV.alertList.rx.items(cellIdentifier: AlertContentCell.cellID, cellType: AlertContentCell.self)) { index, alertContent, cell in
            
        }
        .disposed(by: self.disposeBag)
    }
}
