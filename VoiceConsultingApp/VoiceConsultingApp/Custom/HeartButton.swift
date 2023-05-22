//
//  HeartButton.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/22.
//

import UIKit

class HeartButton: UIButton {
    weak var delegate: HeartButtonDelegate?
    
    var didTap: Bool = false {
        didSet {
            if didTap {
                self.setImage(UIImage(named: AssetImage.heart_Fill), for: .normal)
            } else {
                self.setImage(UIImage(named: AssetImage.heart), for: .normal)
            }
        }
    }
    var fill: Bool = false
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        if fill {
            didTap = true
        } else {
            didTap = false
        }
        
        self.addTarget(self, action: #selector(didTapAction), for: .touchDown)
    }
    
    @objc func didTapAction() {
        didTap = !didTap
        delegate?.didTapHeartButton(didTap: didTap)
    }
}
