//
//  CoinBlock.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/03.
//

import UIKit
import Then
import SnapKit

class CoinBlock: UIView {
    var isFill: Bool = false {
        didSet {
            if isFill {
                self.coinCount.textColor = ColorSet.mainColor
                self.layer.borderColor = ColorSet.mainColor?.cgColor
                self.layer.borderWidth = 1
                self.backgroundColor = .white
                self.coinImage.image = UIImage(named: AssetImage.coinIconFill)
            }
        }
    }
    
    private lazy var coinImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.coinIcon)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var coinCount: UILabel = UILabel().then {
        $0.text = "150,000"
        $0.font = UIFont(name: Fonts.Inter_Bold, size: 16)
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var stackView: UIStackView = UIStackView(arrangedSubviews: [coinImage, coinCount]).then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
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
        self.layer.cornerRadius = 6
    }
    
    private func constraint() {
        self.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        
        self.coinImage.snp.makeConstraints { image in
            image.width.height.equalTo(16)
        }
        
        self.coinCount.snp.makeConstraints { label in
            label.height.equalTo(16)
        }
        
        self.addSubview(stackView)
        
        self.stackView.snp.makeConstraints { sv in
            sv.left.equalTo(self.snp.left).offset(10)
            sv.centerY.equalTo(self.snp.centerY)
            sv.right.equalTo(self.snp.right).offset(-10)
        }
    }
}
