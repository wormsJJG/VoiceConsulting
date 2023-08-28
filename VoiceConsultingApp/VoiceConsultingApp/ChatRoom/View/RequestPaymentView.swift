//
//  RequestPaymentView.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/05.
//

import UIKit
import Then
import SnapKit

class RequestPaymentView: UIView {
    
    let requestButton: UIButton = UIButton().then {
        $0.setTitle("결제 요청하기", for: .normal)
        $0.setTitleColor(ColorSet.mainColor, for: .normal)
        $0.titleLabel?.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
        $0.layer.borderColor = ColorSet.mainColor?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
        self.addSubview(requestButton)
        
        requestButton.snp.makeConstraints {
            $0.edges.equalTo(self.snp.edges).inset(UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
