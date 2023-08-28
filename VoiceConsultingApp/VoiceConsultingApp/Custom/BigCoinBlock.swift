//
//  BigCoinBlock.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import Then
import SnapKit

class BigCoinBlock: UIView {
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.text = "보유캐쉬"
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 14)
        $0.textColor = .white
    }

    private lazy var coinImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.coinIcon)
    }
    
    lazy var coinCount: UILabel = UILabel().then {
        $0.text = String(Config.coin)
        $0.font = UIFont(name: Fonts.Inter_Bold, size: 20)
        $0.textColor = .white
    }
    
    private lazy var coinStackView: UIStackView = UIStackView(arrangedSubviews: [coinImage, coinCount]).then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var nextImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.right)
    }
    
    private lazy var rightStackView: UIStackView = UIStackView(arrangedSubviews: [coinStackView, nextImage]).then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.alignment = .center
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [titleLabel, rightStackView]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setBlockDesign()
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setBlockDesign() {
        self.backgroundColor = ColorSet.mainColor
        self.layer.cornerRadius = 10
    }
    // MARK: - Constraint
    private func constraint() {
        self.coinImage.snp.makeConstraints { image in
            image.width.height.equalTo(18)
        }
        
        self.addSubview(allStackView)
        
        self.allStackView.snp.makeConstraints { sv in
            sv.left.equalTo(self.snp.left).offset(16)
            sv.right.equalTo(self.snp.right).offset(-16)
            sv.centerY.equalTo(self.snp.centerY)
        }
    }
}
