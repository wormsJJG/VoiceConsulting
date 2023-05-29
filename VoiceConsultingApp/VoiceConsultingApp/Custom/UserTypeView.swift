//
//  UserTypeView.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/29.
//

import UIKit
import SnapKit
import Then

class UserTypeView: UIView {
    
    var isUser: Bool = true {
        didSet {
            if isUser {
                self.backgroundColor = ColorSet.mainText
                self.typeLabel.text = "사용자"
            } else {
                self.backgroundColor = ColorSet.mainColor
                self.typeLabel.text = "상담사"
            }
        }
    }
    
    private let typeLabel: UILabel = UILabel().then {
        $0.text = "type"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 12)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 11
        self.clipsToBounds = true
        
        self.addSubview(typeLabel)
        
        typeLabel.snp.makeConstraints {
            $0.edges.equalTo(self.snp.edges).inset(UIEdgeInsets(top: 2, left: 6, bottom: 3, right: 6))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
