//
//  HeartButton.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/22.
//

import UIKit

class HeartButton: BaseButton {
    weak var delegate: HeartButtonDelegate?
    
    var isHeart: Bool = false {
        
        didSet {
            
            if isHeart {
                
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
            
            isHeart = true
        } else {
            
            isHeart = false
        }
        
        self.addTarget(self, action: #selector(didTapAction), for: .touchDown)
    }
    
    @objc func didTapAction() {
        
        isHeart = !isHeart
        delegate?.didTapHeartButton(didTap: isHeart)
    }
}
