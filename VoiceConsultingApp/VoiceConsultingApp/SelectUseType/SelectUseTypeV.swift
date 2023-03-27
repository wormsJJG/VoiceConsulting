//
//  SelectUseTypeV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/27.
//

import UIKit
import SnapKit
import Then

class SelectUseTypeV: UIView {
    // MARK: - Componet
    private lazy var discritionLabel: UILabel = UILabel().then {
        $0.text = "사용하실 계정을 선택해주세요"
    }
    
    private lazy var userButton: UIButton = UIButton().then {
        $0.setTitle("사용자", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private lazy var counselorButton: UIButton = UIButton().then {
        $0.setTitle("상담사", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private lazy var buttonStackView: UIStackView = UIStackView(arrangedSubviews: [userButton,
                                                                            counselorButton]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    private lazy var nextButton: UIButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Constraint
    private func constraint() {
        // 설명 레이블
        self.addSubview(self.discritionLabel)
        
        self.discritionLabel.snp.makeConstraints { label in
            label.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(30)
            label.left.equalTo(self.snp.left).offset(30)
            label.right.equalTo(self.snp.right).offset(-30)
        }
        // 선택버튼 스택뷰
        self.addSubview(buttonStackView)
        
        self.buttonStackView.snp.makeConstraints { stackView in
            stackView.height.equalTo(100)
            stackView.top.equalTo(self.discritionLabel.snp.bottom).offset(50)
            stackView.left.equalTo(self.snp.left).offset(30)
            stackView.right.equalTo(self.snp.right).offset(-30)
        }
        // 다음버튼 스택뷰
        self.addSubview(nextButton)
        
        self.nextButton.snp.makeConstraints { button in
            button.height.equalTo(50)
            button.left.equalTo(self.snp.left).offset(30)
            button.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            button.right.equalTo(self.snp.right).offset(-30)
        }
        
    }
}
