//
//  SplashV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/23.
//

import UIKit
import Then
import SnapKit

class SplashV: UIView {
    // MARK: - UI Component
    let logoImageView: UIImageView = UIImageView().then {
        
        $0.image = UIImage(named: AssetImage.logoImage)
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(logoImageView)
        self.logoImageView.snp.makeConstraints { imageView in
            
            imageView.centerX.equalTo(self.snp.centerX)
            imageView.centerY.equalTo(self.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - AddSubView
    
    // MARK: - Constraints
}
