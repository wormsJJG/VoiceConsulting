//
//  ProfileCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/20.
//

import UIKit
import SnapKit
import Then

class ProfileCell: UITableViewCell {
    static let cellID = "profileCell"
    
    let profileimage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.thumnail)
    }
    
    let counselorName: UILabel = UILabel().then {
        $0.text = "김이름 상담사"
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 16)
        $0.textColor = ColorSet.mainText
    }
    
    private lazy var topStackView: UIStackView = UIStackView(arrangedSubviews: [profileimage, counselorName]).then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .center
    }
    
    let introduce: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textColor = ColorSet.subTextColor
        $0.numberOfLines = 2
        $0.text = "소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소"
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [topStackView, introduce]).then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.alignment = .leading
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        profileimage.snp.makeConstraints {
            $0.width.height.equalTo(50)
        }
        
        self.contentView.addSubview(allStackView)
        
        allStackView.snp.makeConstraints {
            $0.left.equalTo(self.contentView.snp.left).offset(20)
            $0.top.equalTo(self.contentView.snp.top)
            $0.right.equalTo(self.contentView.snp.right).offset(-20)
            $0.bottom.equalTo(self.contentView.snp.bottom)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
