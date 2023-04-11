//
//  MyPageVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import RxSwift
import RxCocoa

class MyPageVC: BaseViewController {
    // MARK: - Load View
    private let myPageV = MyPageV()
    
    override func loadView() {
        self.view = myPageV
    }
    // MARK: - Properties
    private let viewModel = MypageVM()
    private let disposeBag = DisposeBag()
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
    }
    // MARK: - Bind TableView
    private func bindTableView() {
        viewModel.menu.bind(to: self.myPageV.menuList.rx.items(cellIdentifier: MenuCell.cellID, cellType: MenuCell.self)) { index, menu, cell in
            cell.configure(menuType: menu)
        }
        .disposed(by: self.disposeBag)
    }
}
