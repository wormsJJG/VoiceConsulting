//
//  ChattingListHeader.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import UIKit
import Then
import SnapKit

class ChattingListHeader: UIView {

    lazy var profileImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.thumnail)
        $0.layer.cornerRadius = 20.0
    }
    
    lazy var name: UILabel = UILabel().then {
        $0.text = "박고민"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 16)
    }
    
    lazy var coinBlock = CoinBlock().then {
        $0.isFill = true
    }
    
    private lazy var leftStackView: UIStackView = UIStackView(arrangedSubviews: [profileImage, name]).then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .center
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [leftStackView, coinBlock]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = ColorSet.chattingListHeader
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
        
        self.profileImage.snp.makeConstraints { image in
            image.width.height.equalTo(40)
        }
        
        self.coinBlock.snp.makeConstraints { block in
            block.height.equalTo(36)
        }
        
        self.addSubview(allStackView)
        
        self.allStackView.snp.makeConstraints { sv in
            sv.left.equalTo(self.snp.left).offset(20)
            sv.right.equalTo(self.snp.right).offset(-20)
            sv.bottom.equalTo(self.snp.bottom).offset(-7)
        }
    }

}
