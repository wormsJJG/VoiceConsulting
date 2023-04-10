//
//  ServiceCenterBlock.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import Then
import SnapKit

class ServiceCenterBlock: UIView {
    private lazy var title: UILabel = UILabel().then {
        $0.text = "고객센터"
        $0.textColor = ColorSet.subTextColor
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 14)
    }
    
    private lazy var icon: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.phoneIcon)
    }
    
    private lazy var phoneNumber: UILabel = UILabel().then {
        $0.text = "010-1234-1234"
        $0.textColor = ColorSet.subTextColor
        $0.font = UIFont(name: Fonts.Inter_Medium, size: 16)
    }
    
    private lazy var rightStackView: UIStackView = UIStackView(arrangedSubviews: [icon, phoneNumber]).then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.alignment = .center
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [title, rightStackView]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        blockDesign()
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func blockDesign() {
        self.layer.borderColor = ColorSet.line?.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10
    }
    
    private func constraint() {
        self.icon.snp.makeConstraints { icon in
            icon.width.height.equalTo(18)
        }
        
        self.addSubview(allStackView)
        
        self.allStackView.snp.makeConstraints { sv in
            sv.left.equalTo(self.snp.left).offset(20)
            sv.right.equalTo(self.snp.right).offset(-20)
            sv.centerY.equalTo(self.snp.centerY)
        }
    }
}
