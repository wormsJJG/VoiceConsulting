//
//  VoIpUtillButton.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/10.
//

import UIKit
import SnapKit
import Then

class VoIpUtillButton: UIView {
    
    var buttonBackgroundColor: UIColor = ColorSet.utillButtonBackground {
        
        didSet {
            
            button.backgroundColor = buttonBackgroundColor
        }
    }
    
    var buttonIcon: UIImage = UIImage() {
        
        didSet {
            
            button.setImage(buttonIcon, for: .normal)
        }
    }
    
    var labelFont: UIFont = UIFont() {
        
        didSet {
            
            buttonDescriptionLabel.font = labelFont
        }
    }
    
    var labelColor: UIColor = ColorSet.mainText! {
        
        didSet {
            
            buttonDescriptionLabel.textColor = labelColor
        }
    }

    lazy var button: UIButton = UIButton().then {
        
        $0.backgroundColor = buttonBackgroundColor
        $0.layer.cornerRadius = 40
        $0.clipsToBounds = true
    }
    
    lazy var buttonDescriptionLabel: UILabel = UILabel().then {
        
        $0.textAlignment = .center
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [button,
                                                                                buttonDescriptionLabel]).then {
        
        $0.axis = .vertical
        $0.spacing = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        button.snp.makeConstraints {
            
            $0.width.height.equalTo(80)
        }
        
        self.addSubview(allStackView)

        allStackView.snp.makeConstraints {

            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
