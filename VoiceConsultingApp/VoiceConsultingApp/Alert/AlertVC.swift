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
    let alertList: PublishSubject<[Message]> = PublishSubject()
    private let disposeBag = DisposeBag()
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addAction()
        bindList()
        fetchMessageList()
    }
}
// MARK: - fetchData
extension AlertVC {
    
    private func fetchMessageList() {
        
        MessageStorage.shared.fetchAllMessage()
            .map { $0.map { $0.toMessage() }}
            .subscribe(onNext: { [weak self] messageList in
                
                self?.alertList.onNext(messageList)
            })
            .disposed(by: self.disposeBag)
    }
}
// MARK: - bindList
extension AlertVC {
    
    private func bindList() {
        self.alertList
            .observe(on: MainScheduler.instance)
            .bind(to: self.alertV.alertList.rx.items(cellIdentifier: AlertContentCell.cellID, cellType: AlertContentCell.self)) { index, message, cell in
            
            cell.configureCell(in: message)
        }
        .disposed(by: self.disposeBag)
    }
}
// MARK: - Add Action
extension AlertVC {
    
    private func addAction() {
        
        self.alertV.headerView.backButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.popVC()
            })
            .disposed(by: self.disposeBag)
    }
}
