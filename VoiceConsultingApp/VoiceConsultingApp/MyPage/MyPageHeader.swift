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

    lazy var alarmButton: BaseButton = BaseButton().then {
        $0.setImage(UIImage(named: AssetImage.alarmIcon), for: .normal)
        $0.setTitle(nil, for: .normal)
    }
    
    lazy var editAccountButton: BaseButton = BaseButton().then {
        $0.setTitle("계정 설정", for: .normal)
        $0.setTitleColor(ColorSet.mainText, for: .normal)
        $0.titleLabel?.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 16)
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
        
        self.alarmButton.snp.makeConstraints { button in
            button.width.height.equalTo(24)
        }
        
        self.addSubview(alarmButton)
        
        alarmButton.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(20)
            $0.centerY.equalTo(self.snp.centerY)
        }
        
        self.addSubview(editAccountButton)
        
        editAccountButton.snp.makeConstraints {
            $0.right.equalTo(self.snp.right).offset(-20)
            $0.centerY.equalTo(self.snp.centerY)
        }
    }
}
