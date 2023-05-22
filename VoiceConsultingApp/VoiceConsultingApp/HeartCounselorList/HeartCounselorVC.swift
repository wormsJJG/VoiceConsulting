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
    let heartCounselorList: PublishSubject<[String]> = PublishSubject()
    private let disposeBag = DisposeBag()
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.heartCounselorV.headerView.backButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.popVC()
            })
            .disposed(by: self.disposeBag)
        bindList()
        heartCounselorList.onNext(["", "", "", "", "", "", "", "", ""])
    }
}
// MARK: - bindList
extension HeartCounselorVC {
    
    private func bindList() {
        self.heartCounselorList.bind(to: self.heartCounselorV.counselorList.rx.items(cellIdentifier: HeartCounselorCell.cellID, cellType: HeartCounselorCell.self)) { index, counselor, cell in
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
