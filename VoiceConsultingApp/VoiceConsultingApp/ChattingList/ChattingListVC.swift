//
//  ChattingListVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture
import Kingfisher

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
        
        addCoinBlockTapAction()
        bindTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bindData()
    }
}
// MARK: - Bind Data
extension ChattingListVC {
    
    private func bindData() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.chattingListV.header.profileImage.kf.setImage(with: URL(string: Config.profileUrlString ?? ""))
            self?.chattingListV.header.coinBlock.coinCount.text = String(Config.coin)
        }
    }
}
// MARK: - Touch Action
extension ChattingListVC {
    
    private func addCoinBlockTapAction() {
        self.chattingListV.header.coinBlock.rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                self?.moveCoinManagementVC(start: 0)
            })
            .disposed(by: self.disposeBag)
    }
}
// MARK: - bind tableView
extension ChattingListVC: UICollectionViewDelegate {
    
    private func bindTableView() {
        self.chattingListV.chattingList.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
        
        self.viewModel.chatList
            .bind(to: self.chattingListV.chattingList.rx.items(cellIdentifier: ChattingCell.cellID, cellType: ChattingCell.self)) { index, chat, cell in
                
                
            }
            .disposed(by: self.disposeBag)
        
        self.chattingListV.chattingList.rx.modelSelected(String.self)
            .bind(onNext: { selectItem in
                print(selectItem)
                self.moveChatRommVC()
            })
            .disposed(by: self.disposeBag)
        
    }
}
