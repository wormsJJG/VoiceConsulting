//
//  PopularCounselorCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/06.
//

import UIKit
import Then
import SnapKit

class PopularCounselorCell: UICollectionViewCell {
    static let cellID = "popularCounselorCell"
    // MARK: - View
    lazy var thumnailImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.thumnail)
        $0.layer.cornerRadius = 30
    }
    
    private lazy var badge: CounselorBadge = CounselorBadge()
    
    lazy var counselorName: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.text = "김이름 상담사"
        $0.textColor = ColorSet.mainText
    }
    
    lazy var introduce: UILabel = UILabel().then {
        $0.textColor = ColorSet.subTextColor
        $0.text = "소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 12)
        $0.numberOfLines = 2
    }
    
    private lazy var star: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.star)
    }
    
    lazy var startCount: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.text = "5.0"
        $0.textAlignment = .left
        $0.textColor = ColorSet.mainText
    }
    
    private lazy var starStackView: UIStackView = UIStackView(arrangedSubviews: [star, startCount]).then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fillProportionally
    }
    
    lazy var consultationCount: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 12)
        $0.text = "상담 4회"
        $0.textColor = ColorSet.subTextColor
    }
    
    private lazy var footerStackView: UIStackView = UIStackView(arrangedSubviews: [starStackView, consultationCount]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [thumnailImage, badge, counselorName, introduce, footerStackView]).then {
        
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .center

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellDesign()
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellDesign() {
        
    }
    
    private func constraint() {
        thumnailImage.snp.makeConstraints { imageView in
            imageView.width.height.equalTo(60)
        }
        
        badge.snp.makeConstraints { badge in
            badge.width.equalTo(self.badge.label.snp.width).offset(12)
            badge.height.equalTo(self.badge.label.snp.height).offset(6)
        }
        
        star.snp.makeConstraints { star in
            star.width.height.equalTo(14)
        }
        
        self.contentView.addSubview(allStackView)
        
        self.allStackView.snp.makeConstraints { stackView in
            stackView.center.equalTo(self.contentView.snp.center)
            stackView.left.equalTo(self.contentView.snp.left).offset(16)
            stackView.right.equalTo(self.contentView.snp.right).offset(-16)
        }
        
        self.footerStackView.snp.makeConstraints { sv in
            sv.left.equalTo(self.allStackView.snp.left)
            sv.right.equalTo(self.allStackView.snp.right)
        }
    }
}
