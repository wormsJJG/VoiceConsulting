//
//  CoinManagementVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import UIKit
import RxSwift
import RxCocoa
import Tabman
import Pageboy
import SnapKit
import StoreKit

class CoinManagementVC: TabmanViewController {
    // MARK: - Load View
    private let coinManagementV = CoinManagementV()
    
    override func loadView() {
        self.view = coinManagementV
    }
    // MARK: - Properties
    private let viewController = [BuyCoinVC(), BuyHistoryVC(), UseHistoryVC()]
    private let disposeBag = DisposeBag()
    var startIndex: Int = 0
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        configureBar()
        addTapAction()
    }
}
// MARK: - TabMan
extension CoinManagementVC: PageboyViewControllerDataSource, TMBarDataSource {
    private func configureBar() {
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .blur(style: .light)
        bar.layout.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        bar.layout.contentMode = .fit
        
        bar.buttons.customize { button in
            button.tintColor = ColorSet.subTextColor2
            button.selectedTintColor = ColorSet.mainColor
            button.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)!
            button.selectedFont = UIFont(name: Fonts.NotoSansKR_Bold, size: 14)!
        }
        
        bar.indicator.weight = .custom(value: 2)
        bar.indicator.tintColor = ColorSet.mainColor
        bar.indicator.superview?.backgroundColor = ColorSet.line
        
        addBar(bar, dataSource: self, at: .custom(view: coinManagementV.tapView, layout: nil))
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "코인구매")
        case 1:
            return TMBarItem(title: "구매내역")
        case 2:
            return TMBarItem(title: "사용내역")
        default:
            return TMBarItem(title: "nil")
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return viewController.count
    }

    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return viewController[index]
    }

    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        if startIndex == 2 {
            return .at(index: startIndex)
        } else {
            return .at(index: 0)
        }
    }
}
// MARK: - Add Tap Action
extension CoinManagementVC {
    private func addTapAction() {
        self.coinManagementV.header.backButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: self.disposeBag)
    }
}
