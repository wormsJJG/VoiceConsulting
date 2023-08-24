//
//  ChatRoomHeader.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/26.
//

import UIKit
import Then
import SnapKit

class ChatRoomHeader: UIView {
    
    let backButton: BaseButton = BaseButton().then {
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
    
    let coinBlock: CoinBlock = CoinBlock().then {
        $0.isFill = true
    }
    
    let heartButton: HeartButton = HeartButton()
    
    let menuButton: BaseButton = BaseButton().then {
        $0.setImage(UIImage(named: AssetImage.menu), for: .normal)
    }
    
    private lazy var rightStackView: UIStackView = UIStackView(arrangedSubviews: [coinBlock, heartButton, menuButton]).then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.alignment = .center
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
        var statusHeight: CGFloat = 0.0
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            statusHeight = window?.safeAreaInsets.top ?? 0
        } else if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            statusHeight = window?.safeAreaInsets.top ?? 0
        }
        
        self.snp.makeConstraints {
            $0.height.equalTo(statusHeight + 54)
        }
        
        self.addSubview(rightStackView)
        
        rightStackView.snp.makeConstraints {
            $0.right.equalTo(self.snp.right).offset(-20)
            $0.bottom.equalTo(self.snp.bottom).offset(-9)
        }

        self.addSubview(leftStackView)
        
        leftStackView.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(20)
            $0.centerY.equalTo(self.rightStackView.snp.centerY)
        }
    }
}
