//
//  RevenueDetailCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/31.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class RevenueDetailCell: UITableViewCell {
    
    static let cellID = "revenueDetailCell"
    
    private let timeLabel: UILabel = UILabel().then {
        
        $0.text = "2023.02.22 10:52"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
    }
    
    private let coinCountLabel: UILabel = UILabel().then {
        
        $0.text = "코인100개"
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 14)
        $0.textColor = ColorSet.mainText
    }
    
    private lazy var topStackView: UIStackView = UIStackView(arrangedSubviews: [timeLabel,
                                                                                coinCountLabel]).then {
        
        $0.axis = .horizontal
        $0.alignment = .center
    }
    
    private let userProfileImageView: UIImageView = UIImageView().then {
        
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        $0.image = UIImage(named: AssetImage.thumnail)
    }
    
    private let userNameLabel: UILabel = UILabel().then {
        
        $0.text = "김이름"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
    }
    
    private lazy var leftStackView: UIStackView = UIStackView(arrangedSubviews: [userProfileImageView,
                                                                                 userNameLabel]).then {
        
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
    }
    
    private let consultingTimeLabel: UILabel = UILabel().then {
        
        $0.text = "상담시간 60:00"
        $0.textColor = ColorSet.subTextColor
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
    }
    
    private lazy var bottomStackView: UIStackView = UIStackView(arrangedSubviews: [leftStackView,
                                                                                   consultingTimeLabel]).then {
        
        $0.axis = .horizontal
        $0.spacing = 20
        $0.alignment = .center
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        userProfileImageView.snp.makeConstraints {
            
            $0.width.height.equalTo(30)
        }
        
        contentView.addSubview(topStackView)
        
        topStackView.snp.makeConstraints {
            
            $0.left.equalTo(contentView.snp.left).offset(20)
            $0.top.equalTo(contentView.snp.top).offset(20)
            $0.right.equalTo(contentView.snp.right).offset(-20)
        }
        
        contentView.addSubview(bottomStackView)
        
        bottomStackView.snp.makeConstraints {
            
            $0.left.equalTo(contentView.snp.left).offset(20)
            $0.top.equalTo(topStackView.snp.bottom).offset(10)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(in cellModel: RevenueDetailCellModel) {
        
        self.timeLabel.text = cellModel.convertCreateAtToString()
        self.coinCountLabel.text = cellModel.convertCoinCountToString()
        self.userNameLabel.text = cellModel.userName
        self.consultingTimeLabel.text = cellModel.convertConsultingTimeToString()
        if let profileUrlString = cellModel.userProfileUrlString {
            
            self.userProfileImageView.kf.setImage(with: URL(string: profileUrlString)) { task in
                
                switch task {
                    
                case .success(_):
                    
                    print("loadSuccess")
                case .failure(_):
                    
                    self.userProfileImageView.backgroundColor = .gray
                }
            }
        } else {
            
            self.userProfileImageView.backgroundColor = .gray
        }
    }
}
