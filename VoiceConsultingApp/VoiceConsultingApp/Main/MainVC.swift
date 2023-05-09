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
        isHiddenNavigationBar()
        bindTableView()
        addCoinBlockTapAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotification()
    }
}
// MARK: - Notification
extension MainVC {
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didTapCounselorCell), name: NotificationName.touchCounselorCell, object: nil)
    }
    
    private func removeNotification() {
        NotificationCenter.default.removeObserver(self, name: NotificationName.touchCounselorCell, object: nil)
    }
    
    @objc private func didTapCounselorCell() {
        let counselorDetailVC = CounselorDetailVC()
        counselorDetailVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(counselorDetailVC, animated: true)
    }
}
// MARK: - Touch Action
extension MainVC {
    
    private func addCoinBlockTapAction() {
        self.mainV.headerView.coinBlock.rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                self?.didTapCoinBlock()
            })
            .disposed(by: self.disposeBag)
    }
}
// MARK: - Bind TableView
extension MainVC: UITableViewDelegate {
    private func bindTableView() {
        self.mainV.mainList.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
        
        self.mainV.mainList.rowHeight = UITableView.automaticDimension
        self.mainV.mainList.estimatedRowHeight = UITableView.automaticDimension
        
        self.viewModel.sectionTitleList
            .bind(to: self.mainV.mainList.rx.items) { [weak self] tableView, row, section in
                switch section {
                    
                case .banner:
                    guard let bannerCell = tableView.dequeueReusableCell(withIdentifier: BannerCell.cellID) as? BannerCell else {
                        
                        return UITableViewCell()
                    }
                    
                    return bannerCell
                    
                case .liveCounselor:
                    
                    guard let liveCounselorCell = tableView.dequeueReusableCell(withIdentifier: LiveCell.cellID) as? LiveCell else {
                        
                        return UITableViewCell()
                    }
                    
                    liveCounselorCell.header.sectionTitle.text = section.sectionTitle
                    
                    let moreLiveVC = MoreLiveVC()
                    moreLiveVC.hidesBottomBarWhenPushed = true
                    
                    liveCounselorCell.header.moreButton.rx.tap
                        .bind(onNext: { [weak self] _ in
                            self?.navigationController?.pushViewController(moreLiveVC, animated: true)
                        })
                        .disposed(by: self!.disposeBag)
                    
                    self?.viewModel.output.onlineCounselorList
                        .bind(onNext: { [weak self] counselorList in
                            liveCounselorCell.onlineCounselorList.onNext(counselorList)
                        })
                        .disposed(by: self!.disposeBag)
                    
                    return liveCounselorCell
                    
                case .popularCounselor:
                    
                    guard let popularCell = tableView.dequeueReusableCell(withIdentifier: PopularCell.cellID) as? PopularCell else {
                        
                        return UITableViewCell()
                    }
                    popularCell.header.sectionTitle.text = section.sectionTitle
                    popularCell.popularCounselorList.onNext(["", "", "", "", "", "", "", "", ""])
                    
                    let morePopularVC = MorePopularVC()
                    morePopularVC.hidesBottomBarWhenPushed = true
                    
                    popularCell.header.moreButton.rx.tap
                        .bind(onNext: { [weak self] _ in
                            self?.navigationController?.pushViewController(morePopularVC, animated: true)
                        })
                        .disposed(by: self!.disposeBag)
                    
                    return popularCell
                    
                case .fitWellCounselor:
                    
                    guard let fitWellCounselorCell = tableView.dequeueReusableCell(withIdentifier: FitWellCell.cellID) as? FitWellCell else {
                        
                        return UITableViewCell()
                    }
                    fitWellCounselorCell.header.sectionTitle.text = section.sectionTitle
                    fitWellCounselorCell.fitWellCounselorList.onNext(["", "", "", "", "", "", "", "", ""])
                    
                    let moreFitWellVC = MoreFitWellVC()
                    moreFitWellVC.hidesBottomBarWhenPushed = true
                    
                    fitWellCounselorCell.header.moreButton.rx.tap
                        .bind(onNext: { [weak self] _ in
                            self?.navigationController?.pushViewController(moreFitWellVC, animated: true)
                        })
                        .disposed(by: self!.disposeBag)
                    
                    return fitWellCounselorCell
                }
            }
            .disposed(by: self.disposeBag)
    }
}
