//
//  Extension+UIView.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/04.
//

import UIKit

extension UIView {
    
    func setViewShadow(backView: UIView) {
        backView.layer.masksToBounds = false
        backView.layer.cornerRadius = 12
        backView.layer.borderWidth = 0
        backView.backgroundColor = .white
    
                
        layer.masksToBounds = false
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 10
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.shadowRadius = 3
    }
    
    func addBottomBorderWithColor(color: UIColor) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height, width: self.frame.size.width, height: 1)
        self.layer.addSublayer(border)
    }
}
