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
        
        MessageClient.shared.delegate = self
        addCoinBlockTapAction()
        bindTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.input.fetchChattingListTrigger.onNext(())
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
        
        self.viewModel.output.channelList
            .bind(to: self.chattingListV.chattingList.rx.items(cellIdentifier: ChattingCell.cellID, cellType: ChattingCell.self)) { index, channel, cell in
                
                cell.configureCell(in: channel)
            }
            .disposed(by: self.disposeBag)
        
        self.chattingListV.chattingList.rx.modelSelected(ChatChannel.self)
            .bind(onNext: { [weak self] chatChannel in
                
                self?.moveChatRoomVC(chatChannel)
            })
            .disposed(by: self.disposeBag)
        
    }
}

// MARK: - MessageClient
extension ChattingListVC: MessageReciveable {
    
    func didReciceMessage(message: Message) {
        
        viewModel.input.fetchChattingListTrigger.onNext(())
    }
}
