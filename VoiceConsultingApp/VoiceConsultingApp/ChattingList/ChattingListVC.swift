//
//  ChattingListVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import RxSwift
import RxCocoa

class ChattingListVC: BaseViewController {
    // MARK: - Load View
    private let chattingListV = ChattingListV()
    override func loadView() {
        self.view = chattingListV
    }
    // MARK: - Properties
    private let viewModel = ChattingListVM()
    private let disposeBag = DisposeBag()
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
    }
    // MARK: - bind tableView
    private func bindTableView() {
        self.viewModel.chatList
            .bind(to: self.chattingListV.chattingList.rx.items(cellIdentifier: ChattingCell.cellID, cellType: ChattingCell.self)) { index, chat, cell in
                
                
            }
            .disposed(by: self.disposeBag)
    }
}
