//
//  SettlementDetailVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/31.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class SettlementDetailVC: UIViewController {
    
    // MARK: - View
    private lazy var settlementDetailTableView: UITableView = UITableView().then {
        $0.register(SettlementDetailCell.self, forCellReuseIdentifier: SettlementDetailCell.cellID)
        $0.showsVerticalScrollIndicator = false
        $0.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private let emptyLabel: UILabel = UILabel().then {
        
        $0.text = "정산내역이 없습니다."
        $0.isHidden = true
        $0.textColor = ColorSet.subTextColor2
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let settlementDetailList: PublishSubject<[String]> = PublishSubject()

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        constraints()
        bindTableView()
        settlementDetailList.onNext(["", "", "", "", ""])
    }
}
// MARK: - bindTableView
extension SettlementDetailVC {
    
    private func bindTableView() {
        
        settlementDetailList
            .filter { $0.count == 0 }
            .bind(onNext: { [weak self] _ in

                self?.emptyLabel.isHidden = false
            })
            .disposed(by: self.disposeBag)
        
        settlementDetailList
            .bind(to: settlementDetailTableView.rx.items(cellIdentifier: SettlementDetailCell.cellID, cellType: SettlementDetailCell.self)) { index, settlementDetail, cell in
                
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Constraints
extension SettlementDetailVC {
    
    private func constraints() {
        
        view.backgroundColor = .white
        
        view.addSubview(settlementDetailTableView)
        
        settlementDetailTableView.snp.makeConstraints {
            
            $0.edges.equalToSuperview()
        }
    }
}
