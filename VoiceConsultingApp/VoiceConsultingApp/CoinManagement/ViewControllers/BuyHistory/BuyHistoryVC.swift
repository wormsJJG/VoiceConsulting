//
//  BuyHistoryVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import UIKit
import RxSwift
import RxCocoa

class BuyHistoryVC: BaseViewController {
    // MARK: - Load View
    private let buyHistoryV = BuyHistoryV()
    
    override func loadView() {
        self.view = buyHistoryV
    }
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let buyHistoryList = Observable.just(["", "", "", "", "", "", "", "", "", ""])
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
    }
}
extension BuyHistoryVC {
    private func bindTableView() {
        self.buyHistoryList
            .bind(to: self.buyHistoryV.buyHistoryList.rx.items(cellIdentifier: BuyHistoryCell.cellID, cellType: BuyHistoryCell.self)) { index, history, cell in
                
            }
            .disposed(by: self.disposeBag)
    }
}
