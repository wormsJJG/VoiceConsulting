//
//  MyPageVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

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
        addCoinBlockTapAction()
        bindTableView()
    }
}
// MARK: - Touch Action
extension MyPageVC {
    
    private func addCoinBlockTapAction() {
        self.myPageV.coinBlock.rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                self?.didTapCoinBlock()
            })
            .disposed(by: self.disposeBag)
    }
}
// MARK: - Bind TableView
extension MyPageVC {
    private func bindTableView() {
        viewModel.menu.bind(to: self.myPageV.menuList.rx.items(cellIdentifier: MenuCell.cellID, cellType: MenuCell.self)) { index, menu, cell in
            cell.configure(menuType: menu)
        }
        .disposed(by: self.disposeBag)
    }
}
