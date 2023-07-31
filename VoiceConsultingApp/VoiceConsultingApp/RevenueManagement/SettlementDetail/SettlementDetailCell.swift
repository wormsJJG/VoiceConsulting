//
//  RevenueDetailCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/31.
//

import UIKit
import Then
import SnapKit

class SettlementDetailCell: UITableViewCell {
    
    static let cellID = "settlementDetailCell"
    
    private let timeLabel: UILabel = UILabel().then {
        
        $0.text = "2023.02.22"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
    }
    
    private let priceLabel: UILabel = UILabel().then {
        
        $0.text = "10,000원"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 16)
    }
    
    private lazy var topStackView: UIStackView = UIStackView(arrangedSubviews: [timeLabel,
                                                                                priceLabel]).then {
        
        $0.axis = .horizontal
        $0.alignment = .center
    }
    
    private let coinCountLabel: UILabel = UILabel().then {
        
        $0.text = "코인 100개"
        $0.textColor = ColorSet.subTextColor
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
    }
    
    private let isCompleteSettlementLabel: UILabel = UILabel().then {
        
        $0.text = "정산완료"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
    }
    
    private lazy var bottomStackView: UIStackView = UIStackView(arrangedSubviews: [coinCountLabel,
                                                                                   isCompleteSettlementLabel]).then {
        
        $0.axis = .horizontal
        $0.alignment = .center
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [topStackView,
                                                                                bottomStackView]).then {
        
        $0.axis = .vertical
        $0.spacing = 6
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        contentView.addSubview(allStackView)
        
        allStackView.snp.makeConstraints {
            
            $0.edges.equalTo(contentView.snp.edges).inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
