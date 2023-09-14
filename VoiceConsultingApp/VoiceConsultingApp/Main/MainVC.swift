//
//  MainVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/26.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import AgoraChat

class MainVC: BaseViewController {
    // MARK: - Load View
    private let mainV = MainV()
    
    override func loadView() {
        self.view = mainV
    }
    // MARK: - properties
    private let viewModel = MainVM()
    private let disposeBag = DisposeBag()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playLoadAnimation()
        outputSubscrive()
        bindTableView()
        addCoinBlockTapAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataBind()
    }
}
// MARK: - dataBind
extension MainVC {

    private func dataBind() {
        
        DispatchQueue.main.async { [weak self] in

            self?.mainV.headerView.coinBlock.coinCount.text = String(Config.coin)
        }
    }
    
    private func outputSubscrive() {
        
        viewModel.output.mainSectionList
            .filter { $0.count > 0 }
            .bind(onNext: { [weak self] _ in
                
                self?.stopAnimation()
            })
            .disposed(by: self.disposeBag)
    }
}
// MARK: - Touch Action
extension MainVC {
    
    private func addCoinBlockTapAction() {
        
        self.mainV.headerView.coinBlock.rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                
                self?.moveCoinManagementVC(start: 0)
            })
            .disposed(by: self.disposeBag)
    }
}

extension MainVC: CellTouchable {
    
    func didTouchCell(_ model: Counselor) {
        
        self.moveCounselorDetailVC(in: model.uid)
    }
}

extension MainVC: MoreButtonTouchable {
    
    func didTouchMoreButton(_ moreType: MoreType) {
        
        switch moreType {
            
        case .live:
            let moreLiveVC = MoreLiveVC()
            moreLiveVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(moreLiveVC, animated: true)
        case .popular:
            let morePopularVC = MorePopularVC()
            morePopularVC.hidesBottomBarWhenPushed = true

            self.navigationController?.pushViewController(morePopularVC, animated: true)
        case .fitWell:
            let moreFitWellVC = MoreFitWellVC()
            moreFitWellVC.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(moreFitWellVC, animated: true)
        }
    }
}

extension MainVC: RefreshButtonDelegate {
    
    func didTapRefreshButton() {
        
        viewModel.input.refreshLiveCounselorTrigger.onNext(())
    }
}
// MARK: - Bind TableView
extension MainVC: UITableViewDelegate {
    
    private func bindTableView() {
        
        self.mainV.mainList.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
        
        self.mainV.mainList.rowHeight = UITableView.automaticDimension
        self.mainV.mainList.estimatedRowHeight = UITableView.automaticDimension
        
        self.viewModel.output.mainSectionList
            .bind(to: self.mainV.mainList.rx.items) { [weak self] tableView, row, sectionModel in

                switch sectionModel.sectionType {
                    
                case .banner:
                    guard let bannerCell = tableView.dequeueReusableCell(withIdentifier: BannerCell.cellID) as? BannerCell else {
                        
                        return UITableViewCell()
                    }
                    
                    return bannerCell
                    
                case .liveCounselor:
                    
                    guard let liveCounselorCell = tableView.dequeueReusableCell(withIdentifier: LiveCell.cellID) as? LiveCell else {
                        
                        return UITableViewCell()
                    }
                    
                    liveCounselorCell.header.sectionTitle.text = sectionModel.sectionType.sectionTitle
                    liveCounselorCell.onNextLiveCounselor(in: sectionModel.sectionItems)
                    liveCounselorCell.cellTouchDelegate = self
                    liveCounselorCell.moreButtonTouchDelegate = self
                    liveCounselorCell.refreshButtonDelegate = self
                    
                    return liveCounselorCell
                    
                case .popularCounselor:
                    
                    guard let popularCell = tableView.dequeueReusableCell(withIdentifier: PopularCell.cellID) as? PopularCell else {
                        
                        return UITableViewCell()
                    }
                    popularCell.header.sectionTitle.text = sectionModel.sectionType.sectionTitle
                    popularCell.cellTouchDelegate = self
                    popularCell.moreButtonTouchDelegate = self
                    popularCell.onNextPopularCounselor(in: sectionModel.sectionItems)
                    
                    return popularCell
                    
                case .fitWellCounselor:
                    
                    guard let fitWellCounselorCell = tableView.dequeueReusableCell(withIdentifier: FitWellCell.cellID) as? FitWellCell else {
                        
                        return UITableViewCell()
                    }
                    
                    fitWellCounselorCell.header.sectionTitle.text = sectionModel.sectionType.sectionTitle
                    fitWellCounselorCell.cellTouchDelegate = self
                    fitWellCounselorCell.moreButtonTouchDelegate = self
                    fitWellCounselorCell.onNextFitWellCounselor(in: sectionModel.sectionItems)
                    
                    return fitWellCounselorCell
                }
            }
            .disposed(by: self.disposeBag)
    }
}
