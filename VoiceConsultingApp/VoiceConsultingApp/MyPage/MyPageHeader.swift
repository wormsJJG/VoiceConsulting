//
//  MyPageHeader.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import Then
import SnapKit

class MyPageHeader: UIView {
    lazy var profileImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.thumnail)
        $0.layer.cornerRadius = 20.0
    }
    
    lazy var name: UILabel = UILabel().then {
        $0.text = "박고민"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 16)
    }
    
    private lazy var alarmButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: AssetImage.alarmIcon), for: .normal)
        $0.setTitle(nil, for: .normal)
    }
    
    private lazy var leftStackView: UIStackView = UIStackView(arrangedSubviews: [profileImage, name]).then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .center
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [leftStackView, alarmButton]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        self.snp.makeConstraints {
            $0.height.equalTo(54)
        }
        
        self.profileImage.snp.makeConstraints { image in
            image.width.height.equalTo(40)
        }
        
        self.alarmButton.snp.makeConstraints { button in
            button.width.height.equalTo(24)
        }
        
        self.addSubview(allStackView)
        
        self.allStackView.snp.makeConstraints { sv in
            sv.left.equalTo(self.snp.left).offset(20)
            sv.right.equalTo(self.snp.right).offset(-20)
            sv.centerY.equalTo(self.snp.centerY)
        }
    }
}
