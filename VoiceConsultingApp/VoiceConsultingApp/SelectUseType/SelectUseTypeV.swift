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
    private lazy var infomationLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 20)
        $0.text = "사용하실 계정을\n선택해주세요"
        $0.numberOfLines = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var userButton: UIButton = UIButton().then {
        $0.titleLabel?.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 18)
        $0.setTitle("사용자", for: .normal)
        $0.setTitleColor(ColorSet.subTextColor, for: .normal)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = ColorSet.nonSelectColor?.cgColor
        $0.layer.cornerRadius = 20
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var counselorButton: UIButton = UIButton().then {
        $0.titleLabel?.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 18)
        $0.setTitle("상담사", for: .normal)
        $0.setTitleColor(ColorSet.subTextColor, for: .normal)
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = ColorSet.nonSelectColor?.cgColor
        $0.layer.cornerRadius = 20
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var buttonStackView: UIStackView = UIStackView(arrangedSubviews: [userButton,
                                        counselorButton]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 12
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var nextButton: CompleteButton = CompleteButton().then {
        $0.titleText = "다음"
        $0.translatesAutoresizingMaskIntoConstraints = false
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
        self.addSubview(self.infomationLabel)
        
        self.infomationLabel.snp.makeConstraints { label in
            label.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(80)
            label.left.equalTo(self.snp.left).offset(20)
            label.right.equalTo(self.snp.right).offset(-20)
        }
        // 선택버튼 스택뷰
        self.addSubview(buttonStackView)
        
        self.buttonStackView.snp.makeConstraints { stackView in
            stackView.height.equalTo(92)
            stackView.top.equalTo(self.infomationLabel.snp.bottom).offset(50)
            stackView.left.equalTo(self.snp.left).offset(20)
            stackView.right.equalTo(self.snp.right).offset(-20)
        }
        // 다음버튼 스택뷰
        self.addSubview(nextButton)
        
        self.nextButton.snp.makeConstraints { button in
            button.height.equalTo(54)
            button.left.equalTo(self.snp.left).offset(20)
            button.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
            button.right.equalTo(self.snp.right).offset(-20)
        }
    }
    
    func clickAction(useType: UseType) {
        switch useType {
        case .user:
            if counselorButton.layer.borderColor == ColorSet.mainColor!.cgColor {
                counselorButton.layer.borderColor = UIColor.lightGray.cgColor
                counselorButton.setTitleColor(.black, for: .normal)
            }
            userButton.layer.borderColor = ColorSet.mainColor?.cgColor
            userButton.setTitleColor(ColorSet.mainColor, for: .normal)
        case .counselor:
            if userButton.layer.borderColor == ColorSet.mainColor!.cgColor {
                userButton.layer.borderColor = UIColor.lightGray.cgColor
                userButton.setTitleColor(.black, for: .normal)
            }
            counselorButton.layer.borderColor = ColorSet.mainColor?.cgColor
            counselorButton.setTitleColor(ColorSet.mainColor, for: .normal)
        }
    }
}
