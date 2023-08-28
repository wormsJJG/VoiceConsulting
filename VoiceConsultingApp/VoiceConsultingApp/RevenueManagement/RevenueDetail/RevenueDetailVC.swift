//
//  RevenueDetailVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/31.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import SnapKit

class RevenueDetailVC: UIViewController {
    
    // MARK: - View
    private lazy var revenueDetailTableView: UITableView = UITableView().then {
        $0.register(RevenueDetailCell.self, forCellReuseIdentifier: RevenueDetailCell.cellID)
        $0.showsVerticalScrollIndicator = false
        $0.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    private let emptyLabel: UILabel = UILabel().then {
        
        $0.text = "수익내역이 없습니다."
        $0.isHidden = true
        $0.textColor = ColorSet.subTextColor2
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let revenueDetailList: PublishSubject<[Consulting]> = PublishSubject()

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        constraints()
        bindTableView()
        fetchConsultingHistoryData()
    }
}
// MARK: - Data Logic
extension RevenueDetailVC {
    
    private func fetchConsultingHistoryData() {
        
        ConsultingHistoryManager.shared.getConsultingHistoryForCounselor()
            .subscribe(on: MainScheduler.instance)
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let consultingList):
                    
                    if consultingList.count != 0 {
                        
                        self?.emptyLabel.isHidden = true
                    }
                    self?.revenueDetailList.onNext(consultingList)
                case .error(let error):
                    
                    print(error.localizedDescription)
                case .completed:
                    
                    print("completed")
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func convertConsultingToCellModl(in consulting: Consulting, completion: @escaping((RevenueDetailCellModel) -> Void)) {
        
        UserManager.shared.fetchUserData(in: consulting.userId)
            .subscribe({ event in
                
                switch event {
                    
                case .next(let user):
                    
                    let cellModel = RevenueDetailCellModel(userName: user.name,
                                                           userProfileUrlString: user.profileImageUrl,
                                                           consultingDetail: consulting)

                    completion(cellModel)
                case .error(_):
                    
                    let cellModel = RevenueDetailCellModel(userName: "알수 없는 사용자",
                                                           userProfileUrlString: nil,
                                                           consultingDetail: consulting)
                    
                    completion(cellModel)
                case .completed:
                    
                    print("completed")
                }
            })
            .disposed(by: self.disposeBag)
    }
}
// MARK: - bindTableView
extension RevenueDetailVC {
    
    private func bindTableView() {
        
        revenueDetailList
            .filter { $0.count == 0 }
            .bind(onNext: { [weak self] _ in

                self?.emptyLabel.isHidden = false
            })
            .disposed(by: self.disposeBag)
        
        revenueDetailList
            .subscribe(on: MainScheduler.instance)
            .bind(to: revenueDetailTableView.rx.items(cellIdentifier: RevenueDetailCell.cellID, cellType: RevenueDetailCell.self)) { [weak self] index, consultingDetail, cell in
                
                self?.convertConsultingToCellModl(in: consultingDetail, completion: { cellModel in
                    
                    cell.configureCell(in: cellModel)
                })
            }
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Constraints
extension RevenueDetailVC {
    
    private func constraints() {
        
        view.backgroundColor = .white
        
        view.addSubview(revenueDetailTableView)
        
        revenueDetailTableView.snp.makeConstraints {
            
            $0.edges.equalToSuperview()
        }
        
        view.addSubview(emptyLabel)
        
        emptyLabel.snp.makeConstraints {
            
            $0.center.equalToSuperview()
        }
    }
}
