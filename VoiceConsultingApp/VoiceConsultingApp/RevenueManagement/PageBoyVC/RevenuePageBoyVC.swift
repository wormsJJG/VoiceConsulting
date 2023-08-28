//
//  RevenuePageBoyVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/31.
//

import UIKit
import Tabman
import Pageboy

class RevenuePageBoyVC: TabmanViewController {

    private let viewControllers = [RevenueDetailVC(), SettlementDetailVC()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureBar()
    }
}

// MARK: - TabMan
extension RevenuePageBoyVC: PageboyViewControllerDataSource, TMBarDataSource {
    
    private func configureBar() {
        
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        bar.backgroundView.style = .blur(style: .light)
        bar.backgroundColor = .white
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
        
        addBar(bar, dataSource: self, at: .top)
    }
    
    func barItem(for bar: Tabman.TMBar, at index: Int) -> Tabman.TMBarItemable {
        
        switch index {
            
        case 0:
            
            return TMBarItem(title: "수익내역")
        case 1:
            
            return TMBarItem(title: "정산내역")
        default:
            
            return TMBarItem(title: "nil")
        }
    }
    
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        
        return viewControllers.count
    }

    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        
        return viewControllers[index]
    }

    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
       
        return .at(index: 0)
    }
}
