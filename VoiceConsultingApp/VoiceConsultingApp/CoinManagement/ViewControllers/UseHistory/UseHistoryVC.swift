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
    private let viewModel = UseHistoryVM()
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindTableView()
        self.viewModel.input.viewDidLoadTrigger.onNext(())
    }
}
extension UseHistoryVC {
    private func bindTableView() {
        
        self.viewModel.output.consultingHistoryList
            .filter { $0.count == 0 }
            .bind(onNext: { [weak self] _ in

                self?.useHistoryV.emptyLabel.isHidden = false
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.consultingHistoryList
            .bind(to: self.useHistoryV.useHistoryList.rx.items(cellIdentifier: UseHistoryCell.cellID, cellType: UseHistoryCell.self)) { index, consultingHistory, cell in
                
                cell.configureCell(in: consultingHistory)
            }
            .disposed(by: self.disposeBag)
    }
}
