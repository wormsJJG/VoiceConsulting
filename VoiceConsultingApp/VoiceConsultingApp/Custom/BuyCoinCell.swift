//
//  BuyCoinCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/14.
//

import UIKit
import Then
import SnapKit

class BuyCoinCell: UIView {
    var coinCount: Int = 100 {
        didSet {
            coinCountLabel.text = "\(coinCount)코인"
        }
    }
    
    var price: String = "10,000원 구매" {
        didSet {
            buyButton.setTitle(price, for: .normal)
        }
    }
    
    private let coinImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.coinIconFill)
    }
    
    private let coinCountLabel: UILabel = UILabel().then {
        $0.text = "100코인"
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 16)
        $0.textColor = ColorSet.mainText
    }
    
    private lazy var coinCountSV: UIStackView = UIStackView(arrangedSubviews: [coinImage, coinCountLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .center
    }
    
    private let buyButton: UIButton = UIButton().then {
        $0.backgroundColor = ColorSet.buyButtonBack
        $0.setTitle("10,000원 구매", for: .normal)
        $0.setTitleColor(ColorSet.mainText, for: .normal)
        $0.titleLabel?.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.contentEdgeInsets = UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
        $0.layer.cornerRadius = 6
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        self.backgroundColor = .white
        setViewShadow(backView: self)
        
        self.snp.makeConstraints {
            $0.height.equalTo(64)
        }
        
        self.addSubview(coinCountSV)
        
        self.coinCountSV.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(16)
            $0.centerY.equalTo(self.snp.centerY)
        }
        
        self.addSubview(buyButton)
        
        self.buyButton.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.right.equalTo(self.snp.right).offset(-15)
            $0.centerY.equalTo(self.snp.centerY)
        }
    }
}
