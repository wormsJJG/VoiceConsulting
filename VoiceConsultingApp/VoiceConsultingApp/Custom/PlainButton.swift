//
//  CompleteButton.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/30.
//

import UIKit

class PlainButton: UIButton {
    
    var titleText: String?
    var buttonBackgroundColor: UIColor?
    var titleTextColor: UIColor?
    
    override var isHighlighted: Bool {
        
        didSet {
            
            if isHighlighted {
                
                alpha = 0.5
            } else {
                
                alpha = 1
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let titleText {
            self.setTitle(titleText, for: .normal)
            self.titleLabel?.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
            self.layer.cornerRadius = 10
            
            if let titleTextColor {
                
                self.setTitleColor(titleTextColor, for: .normal)
            } else {
                
                self.setTitleColor(.white, for: .normal)
            }
            
            if let buttonBackgroundColor {
                
                self.layer.backgroundColor = buttonBackgroundColor.cgColor
            } else {
                
                self.layer.backgroundColor = ColorSet.mainColor?.cgColor
            }
        }
    }
}
