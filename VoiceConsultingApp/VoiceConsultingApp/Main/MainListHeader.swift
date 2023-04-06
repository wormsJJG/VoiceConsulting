//
//  MainListHeader.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/03.
//

import UIKit
import Then
import SnapKit

class MainListHeader: UIView {
    lazy var sectionTitle: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 16)
        $0.text = "SectionTitle"
        $0.textColor = ColorSet.mainText
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var refreshButton: UIButton = UIButton().then {
        $0.setTitle("새로고침", for: .normal)
        $0.setTitleColor(ColorSet.subTextColor, for: .normal)
        $0.titleLabel?.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var moreButton: UIButton = UIButton().then {
        $0.setTitle("더보기 +", for: .normal)
        $0.setTitleColor(ColorSet.subTextColor, for: .normal)
        $0.titleLabel?.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var leftStackView: UIStackView = UIStackView(arrangedSubviews: [sectionTitle, refreshButton]).then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [leftStackView, moreButton]).then {
        $0.axis = .horizontal
        $0.distribution = .equalCentering
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        self.addSubview(allStackView)
        
        self.allStackView.snp.makeConstraints { sv in
            sv.left.equalTo(self.snp.left).offset(20)
            sv.top.equalTo(self.snp.top).offset(10)
            sv.right.equalTo(self.snp.right).offset(-20)
            sv.bottom.equalTo(self.snp.bottom).offset(-10)
        }
    }
}
