//
//  MorePopularCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import SnapKit
import Then

class MorePopularCell: UITableViewCell {
    static let cellID = "MorePopularCell"
    //MARK: - View
    lazy var thumnailImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.thumnail)
        $0.layer.cornerRadius = 40
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
        $0.text = "상담 400회"
        $0.textColor = ColorSet.subTextColor
    }
    
    private lazy var footerStackView: UIStackView = UIStackView(arrangedSubviews: [starStackView, consultationCount]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    lazy var labelStackView: UIStackView = UIStackView(arrangedSubviews: [badge, counselorName, introduce]).then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .leading
    }
    
    private lazy var topStackView: UIStackView = UIStackView(arrangedSubviews: [thumnailImage, labelStackView]).then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.alignment = .top
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [topStackView, footerStackView]).then {
        $0.axis = .vertical
        $0.spacing = 10
    }
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraint()
        textColorChange()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: - constraint
    private func constraint() {
        self.thumnailImage.snp.makeConstraints { image in
            image.width.height.equalTo(80)
        }
        
        badge.snp.makeConstraints { badge in
            badge.width.equalTo(self.badge.label.snp.width).offset(12)
            badge.height.equalTo(self.badge.label.snp.height).offset(6)
        }
        
        star.snp.makeConstraints { star in
            star.width.height.equalTo(14)
        }
        
        self.contentView.addSubview(allStackView)
        
        self.allStackView.snp.makeConstraints { sv in
            sv.left.equalTo(self.contentView.snp.left).offset(20)
            sv.top.equalTo(self.contentView.snp.top).offset(20)
            sv.right.equalTo(self.contentView.snp.right).offset(-20)
            sv.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
        }
    }
    // MARK: - func
    private func textColorChange() {
        guard let text = self.consultationCount.text else { return }
        let attributeString = NSMutableAttributedString(string: text)

        attributeString.addAttribute(.foregroundColor, value: ColorSet.mainColor!, range: (text as NSString).range(of: text.filter { $0.isNumber }))

        // myLabel에 방금 만든 속성을 적용합니다.
        self.consultationCount.attributedText = attributeString
    }
}
