//
//  BuyHistoryV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import UIKit
import Then
import SnapKit

class BuyHistoryV: UIView {
    
    lazy var buyHistoryList: UITableView = UITableView().then {
        $0.register(BuyHistoryCell.self, forCellReuseIdentifier: BuyHistoryCell.cellID)
        $0.showsVerticalScrollIndicator = false
        $0.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        self.addSubview(buyHistoryList)
        
        self.buyHistoryList.snp.makeConstraints { list in
            list.left.equalTo(self.snp.left)
            list.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(97)
            list.right.equalTo(self.snp.right)
            list.bottom.equalTo(self.snp.bottom)
        }
    }
}
