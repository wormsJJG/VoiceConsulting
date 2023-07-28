//
//  VoiceRoomV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/07.
//

import UIKit
import SnapKit
import Then

class VoiceRoomV: UIView {
    
    // MARK: - View Components
    private let profileContainerView: UIView = UIView().then {

        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 68
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorSet.mainColor?.cgColor
        $0.layer.masksToBounds = true
    }

    private lazy var profileImageView: UIImageView = UIImageView().then {
        
        $0.image = UIImage(named: AssetImage.thumnail)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 30
    }
    
    private lazy var nameLabel: UILabel = UILabel().then {
        
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 18)
        $0.textColor = ColorSet.mainText
        $0.text = "김이름 상담사"
        $0.layer.masksToBounds = true
        $0.textAlignment = .center
    }
    
    private lazy var timeLabel: UILabel = UILabel().then {
        
        $0.font = UIFont(name: Fonts.Inter_Bold, size: 24)
        $0.textColor = ColorSet.mainText
        $0.text = "60:00"
        $0.layer.masksToBounds = true
        $0.textAlignment = .center
    }
    
    private lazy var labelStackView: UIStackView = UIStackView(arrangedSubviews: [nameLabel,
                                                                                  timeLabel]).then {
        
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private lazy var profileAndLabelStackView: UIStackView = UIStackView(arrangedSubviews: [profileContainerView,
                                                                                            labelStackView]).then {
        
        $0.axis = .vertical
        $0.spacing = 20
    }
    
    lazy var muteButtonView: VoIpUtillButton = VoIpUtillButton().then {
        
        $0.buttonBackgroundColor = ColorSet.utillButtonBackground
        $0.buttonDescriptionLabel.text = "음소거"
        $0.labelColor = ColorSet.mainText!
        $0.labelFont = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)!
        $0.buttonIcon = UIImage(named: AssetImage.muteIcon)!
    }
    
    lazy var speakerButtonView: VoIpUtillButton = VoIpUtillButton().then {
        
        $0.buttonBackgroundColor = ColorSet.utillButtonBackground
        $0.buttonDescriptionLabel.text = "스피커"
        $0.labelColor = ColorSet.mainText!
        $0.labelFont = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)!
        $0.buttonIcon = UIImage(named: AssetImage.speakerIcon)!
    }
    
    private lazy var utillButtonStackView: UIStackView = UIStackView(arrangedSubviews: [muteButtonView,
                                                                                        speakerButtonView]).then {
        
        $0.axis = .horizontal
        $0.spacing = 60
    }
    
    lazy var callExitButtonView: VoIpUtillButton = VoIpUtillButton().then {
        
        $0.buttonBackgroundColor = ColorSet.callExitButtonBackground
        $0.buttonDescriptionLabel.text = "종료"
        $0.labelColor = ColorSet.callExitButtonBackground
        $0.labelFont = UIFont(name: Fonts.NotoSansKR_Bold, size: 16)!
        $0.buttonIcon = UIImage(named: AssetImage.callExitIcon)!
    }
    
    private lazy var allButtonStackView: UIStackView = UIStackView(arrangedSubviews: [utillButtonStackView,
                                                                                      callExitButtonView]).then {
        
        $0.axis = .vertical
        $0.spacing = 60
        $0.alignment = .center
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [profileAndLabelStackView,
                                                                                allButtonStackView]).then {
        
        $0.axis = .vertical
        $0.spacing = 108
        $0.alignment = .center
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
        
        self.profileContainerView.addSubview(profileImageView)
        
        self.profileContainerView.snp.makeConstraints { view in
            view.width.height.equalTo(136)
        }
        
        self.profileImageView.snp.makeConstraints { image in
            image.width.height.equalTo(120)
            image.center.equalTo(self.profileContainerView.snp.center)
        }
        
        self.addSubview(allStackView)
        
        allStackView.snp.makeConstraints {
            
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(103)
        }
    }
}
