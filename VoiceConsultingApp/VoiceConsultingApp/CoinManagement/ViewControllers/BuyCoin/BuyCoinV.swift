//
//  BuyCoinView.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import UIKit
import Then
import SnapKit

class BuyCoinV: UIView {
    private lazy var subTextLabel: UILabel = UILabel().then {
        $0.text = "현재 보유중인 코인"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
    }
    
    private lazy var coinImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.coinIconFill)
    }
    
    private lazy var coinCount: UILabel = UILabel().then {
        $0.text = "150000코인"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 16)
    }
    
    private lazy var coinStackView: UIStackView = UIStackView(arrangedSubviews: [coinImage, coinCount]).then {
        $0.axis = .horizontal
        $0.spacing = 6
        $0.alignment = .center
    }
    
    private lazy var allCoinStackView: UIStackView = UIStackView(arrangedSubviews: [subTextLabel, coinStackView]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
        textColorChange()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        self.coinImage.snp.makeConstraints {
            $0.width.height.equalTo(16)
        }
        self.addSubview(allCoinStackView)
        
        self.allCoinStackView.snp.makeConstraints { sv in
            sv.left.equalTo(self.snp.left).offset(20)
            sv.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(117)
            sv.right.equalTo(self.snp.right).offset(-20)
        }
    }
    
    private func textColorChange() {
        guard let text = self.coinCount.text else { return }
        let attributeString = NSMutableAttributedString(string: text)

        attributeString.addAttribute(.foregroundColor, value: ColorSet.mainColor!, range: (text as NSString).range(of: text.filter { $0.isNumber }))

        // myLabel에 방금 만든 속성을 적용합니다.
        self.coinCount.attributedText = attributeString
    }
}
