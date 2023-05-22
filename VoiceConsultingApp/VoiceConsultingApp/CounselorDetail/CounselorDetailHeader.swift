//
//  CounselorDetailHeader.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/29.
//

import UIKit

class CounselorDetailHeader: UIView {
    
    let backButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: AssetImage.backButton), for: .normal)
    }
    
    let counselorLabel: UILabel = UILabel().then {
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
        $0.text = "김이름 상담사"
    }
    
    private lazy var leftStackView: UIStackView = UIStackView(arrangedSubviews: [backButton, counselorLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 16
        $0.alignment = .center
    }
    
    let heartButton: HeartButton = HeartButton()
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [leftStackView, heartButton]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        self.snp.makeConstraints {
            $0.height.equalTo(54)
        }
    
        self.addSubview(allStackView)
        
        self.allStackView.snp.makeConstraints { sv in
            sv.left.equalTo(self.snp.left).offset(20)
            sv.centerY.equalTo(self.snp.centerY)
            sv.right.equalTo(self.snp.right).offset(-20)
        }
    }
}
