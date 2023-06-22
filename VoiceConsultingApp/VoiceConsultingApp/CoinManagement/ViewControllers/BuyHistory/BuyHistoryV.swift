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
    
    let emptyLabel: UILabel = UILabel().then {
        
        $0.text = "코인을 구매하신 내역이\n없습니다."
        $0.isHidden = true
        $0.textColor = ColorSet.subTextColor2
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
        $0.numberOfLines = 2
        $0.textAlignment = .center
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
        
        self.addSubview(emptyLabel)
        
        self.emptyLabel.snp.makeConstraints {
            
            $0.center.equalTo(self.snp.center)
        }
    }
}
