//
//  PlainTextField.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/20.
//

import UIKit

class PlainTextField: UITextField {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
//        textColor = ColorSet.mainText
//        font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
//        layer.cornerRadius = 10
//        layer.borderColor = ColorSet.line?.cgColor
//        layer.borderWidth = 1
//        clipsToBounds = true
//        heightAnchor.constraint(equalToConstant: 48).isActive = true
//        addLeftPadding(in: 16)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textColor = ColorSet.mainText
        font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        layer.cornerRadius = 10
        layer.borderColor = ColorSet.line?.cgColor
        layer.borderWidth = 1
        clipsToBounds = true
        heightAnchor.constraint(equalToConstant: 48).isActive = true
        addLeftPadding(in: 16)
        returnKeyType = .done
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
