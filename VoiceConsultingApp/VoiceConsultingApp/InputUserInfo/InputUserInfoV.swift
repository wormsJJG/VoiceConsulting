//
//  InputUserInfoV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/17.
//

import UIKit
import Then
import SnapKit

class InputUserInfoV: UIView {
    
    let header: PlainHeaderView = PlainHeaderView().then {
        
        $0.isHiddenRefreshButton = true
        $0.headerType = .inputCounselrInfo
    }
    
    let nextButton: PlainButton = PlainButton().then {
        
        $0.titleText = "다음"
    }
    
    private let inputProfileTitle: UILabel = UILabel().then {
        
        $0.text = "프로필 사진"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textColor = ColorSet.mainText
        $0.textAlignment = .left
    }
    
    let profileImageView: UIImageView = UIImageView().then {
        
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 40
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorSet.line?.cgColor
        $0.image = UIImage(named: AssetImage.defaultProfileImage)
        $0.layer.masksToBounds = true
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
    }
    
    let selectProfileButton: UIButton = UIButton().then {
        
        $0.backgroundColor = ColorSet.line
        $0.layer.cornerRadius = 17
        $0.layer.masksToBounds = true
        $0.setImage(UIImage(named: AssetImage.cameraIconFull), for: .normal)
        $0.clipsToBounds = true
    }
    
    private lazy var inputProfileStackView: UIStackView = UIStackView(arrangedSubviews: [inputProfileTitle,
                                                                                         profileImageView]).then {
        
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 20
    }
    
    private let inputNameTitle: UILabel = UILabel().then {
        
        $0.text = "이름"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textColor = ColorSet.mainText
        $0.textAlignment = .left
    }
    
    let inputNameTextField: PlainTextField = PlainTextField().then {
        
        $0.placeholder = "실명을 입력해주세요"
    }
    
    private lazy var inputNameStackView: UIStackView = UIStackView(arrangedSubviews: [inputNameTitle,
                                                                                         inputNameTextField]).then {
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 10
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [inputProfileStackView,
                                                                                inputNameStackView]).then {
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 40
    }
    
    private func constraints() {
        
        self.addSubview(header)
        
        header.snp.makeConstraints {
            
            $0.left.equalTo(self.snp.left)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.right.equalTo(self.snp.right)
        }
        
        self.addSubview(nextButton)
        
        nextButton.snp.makeConstraints {
            
            $0.left.equalTo(self.snp.left).offset(20)
            $0.right.equalTo(self.snp.right).offset(-20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
            $0.height.equalTo(54)
        }
        
        profileImageView.snp.makeConstraints {
            
            $0.width.height.equalTo(80)
        }
        
        self.addSubview(allStackView)
        
        allStackView.snp.makeConstraints {
            
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(self.header.snp.bottom).offset(80)
            $0.right.equalToSuperview().offset(-20)
        }
        
        inputProfileStackView.snp.makeConstraints {
            
            $0.left.equalTo(self.allStackView.snp.left)
            $0.right.equalTo(self.allStackView.snp.right)
        }
        
        inputProfileTitle.snp.makeConstraints {
            
            $0.left.equalTo(self.allStackView.snp.left)
        }
        
        self.addSubview(selectProfileButton)
        
        selectProfileButton.snp.makeConstraints {
            
            $0.height.width.equalTo(34)
            $0.top.equalTo(profileImageView.snp.top).offset(56)
            $0.left.equalTo(profileImageView.snp.left).offset(56)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
