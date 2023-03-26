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
    let label: UILabel = UILabel().then {
        $0.textColor = .blue
        $0.text = "로고"
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        self.label.snp.makeConstraints { l in
            l.centerX.equalTo(self.snp.centerX)
            l.centerY.equalTo(self.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - AddSubView
    
    // MARK: - Constraints
}
