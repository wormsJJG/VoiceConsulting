//
//  ReviewCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/07.
//

import UIKit
import SnapKit
import Then

class ReviewCell: UITableViewCell {
    static let cellID = "reviewCell"
    
    private lazy var star: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.star)
    }
    
    lazy var startCount: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
        $0.text = "5.0"
        $0.textAlignment = .left
        $0.textColor = ColorSet.mainText
    }
    
    private lazy var starStackView: UIStackView = UIStackView(arrangedSubviews: [star, startCount]).then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fillProportionally
    }
    
    private let dateLabel: UILabel = UILabel().then {
        $0.text = "2023.02.22"
        $0.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 12)
        $0.textColor = ColorSet.date
    }
    
    private lazy var topStackView: UIStackView = UIStackView(arrangedSubviews: [starStackView, dateLabel]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    private lazy var reviewLabel: UILabel = UILabel().then {
        $0.text = "후기후기후기후기후기후기후기후기후기후기후기후후기후기후기후기후기후기후기후기후기후기후기후후기후기후기후기후기후기후기후기후기후기후기후기후기후기후기후기후후기후기후기후기후기후기후후기후기후기후기후기후기후기후기후기후기후기후후기후기후기후기후기후후기후기후기후기후기후기후기후기후기후기후기후기후기후기후기후기후기후후기후기후기후기후기후기후기후기후기후기후기후후기후기후기후기후기후기후기후기후기후기후기후기"
        $0.numberOfLines = 0
        $0.textColor = ColorSet.subTextColor2
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 12)
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [topStackView, reviewLabel]).then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .fill
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        star.snp.makeConstraints { star in
            star.width.height.equalTo(14)
        }
        
        self.contentView.addSubview(allStackView)
        
        allStackView.snp.makeConstraints {
            $0.left.equalTo(self.contentView.snp.left).offset(20)
            $0.top.equalTo(self.contentView.snp.top).offset(20)
            $0.right.equalTo(self.contentView.snp.right).offset(-20)
            $0.bottom.equalTo(self.contentView.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
