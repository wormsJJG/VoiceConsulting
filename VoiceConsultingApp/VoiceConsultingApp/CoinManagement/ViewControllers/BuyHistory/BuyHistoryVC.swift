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
    private let viewModel = BuyHistoryVM()
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindTableView()
        self.viewModel.input.viewDidLoadTrigger.onNext(())
    }
}
extension BuyHistoryVC {
    private func bindTableView() {
        
        self.viewModel.output.buyCoinHistoryList
            .filter { $0.count == 0 }
            .bind(onNext: { [weak self] _ in

                self?.buyHistoryV.emptyLabel.isHidden = false
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.buyCoinHistoryList
            .bind(to: self.buyHistoryV.buyHistoryList.rx.items(cellIdentifier: BuyHistoryCell.cellID, cellType: BuyHistoryCell.self)) { index, history, cell in
                
                cell.configureCell(in: history)
            }
            .disposed(by: self.disposeBag)
    }
}
