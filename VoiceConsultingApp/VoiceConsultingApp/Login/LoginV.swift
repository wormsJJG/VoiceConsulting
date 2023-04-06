//
//  LoginV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/31.
//

import UIKit
import Then
import SnapKit

class LoginV: UIView {
    lazy var kakaoLoginButton: UIButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: AssetImage.kakaoLogin), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var appleLoginButton: UIButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: AssetImage.appleLogin), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var googleLoginButton: UIButton = UIButton().then {
        $0.setBackgroundImage(UIImage(named: AssetImage.googleLogin), for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var buttonSV: UIStackView = UIStackView(arrangedSubviews: [kakaoLoginButton,
                                                                            appleLoginButton,
                                                                            googleLoginButton]).then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        kakaoLoginButton.snp.makeConstraints { button in
            button.height.equalTo(50)
        }

        appleLoginButton.snp.makeConstraints { button in
            button.height.equalTo(50)
        }

        googleLoginButton.snp.makeConstraints { button in
            button.height.equalTo(50)
        }
        
        self.addSubview(buttonSV)
        
        self.buttonSV.snp.makeConstraints { stackView in
            stackView.left.equalTo(self.snp.left).offset(20)
            stackView.bottom.equalTo(self.snp.bottom).offset(-72)
            stackView.right.equalTo(self.snp.right).offset(-20)
        }
    }
}
