//
//  UseHistoryCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import UIKit
import Then
import SnapKit

class UseHistoryCell: UITableViewCell {
    static let cellID = "UseHistoryCell"
    
    private lazy var counselorProfile: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.thumnail)
        $0.layer.cornerRadius = 15
    }
    
    private lazy var counselorNameLabel: UILabel = UILabel().then {
        $0.text = "김이름 상담사"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 14)
    }
    
    private lazy var useDateLabel: UILabel = UILabel().then {
        $0.text = "2023.02.22"
        $0.textColor = ColorSet.date
        $0.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 12)
    }
    
    private lazy var topLeft: UIStackView = UIStackView(arrangedSubviews: [counselorProfile, counselorNameLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
    }
    
    private lazy var top: UIStackView = UIStackView(arrangedSubviews: [topLeft, useDateLabel]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    
    private lazy var consultationTimeLabel: UILabel = UILabel().then {
        $0.text = "상담시간  60:00"
        $0.textColor = ColorSet.subTextColor
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
    }
    
    private lazy var useCoinLabel: UILabel = UILabel().then {
        $0.text = "사용코인 70개"
        $0.textColor = ColorSet.subTextColor
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
    }
    
    private lazy var refundCoinLabel: UILabel = UILabel().then {
        $0.text = "환불코인 30개"
        $0.textColor = ColorSet.mainColor
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
    }
    
    private lazy var bottom: UIStackView = UIStackView(arrangedSubviews: [useCoinLabel, refundCoinLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.alignment = .center
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [top, consultationTimeLabel, bottom]).then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 10
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        self.counselorProfile.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        
        self.contentView.addSubview(allStackView)
        
        self.allStackView.snp.makeConstraints { sv in
            sv.left.equalTo(self.contentView.snp.left).offset(20)
            sv.top.equalTo(self.contentView.snp.top).offset(20)
            sv.right.equalTo(self.contentView.snp.right).offset(-20)
            sv.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
        }
        
        self.top.snp.makeConstraints {
            $0.right.equalTo(self.allStackView.snp.right)
        }
    }
}
