//
//  UseHistoryVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import UIKit
import RxCocoa
import RxSwift

class UseHistoryVC: UIViewController {
    // MARK: - Load View
    private let useHistoryV = UseHistoryV()
    
    override func loadView() {
        self.view = useHistoryV
    }
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let useHistoryList = Observable.just(["", "", "", "", "", "", "", "", "", ""])
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
    }
}
extension UseHistoryVC {
    private func bindTableView() {
        self.useHistoryList
            .bind(to: self.useHistoryV.useHistoryList.rx.items(cellIdentifier: UseHistoryCell.cellID, cellType: UseHistoryCell.self)) { index, history, cell in
                
            }
            .disposed(by: self.disposeBag)
    }
}
