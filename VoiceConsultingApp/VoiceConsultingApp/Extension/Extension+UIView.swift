//
//  Extension+UIView.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/04.
//

import UIKit

extension UIView {
    
    func setViewShadow(backView: UIView) {
        backView.layer.masksToBounds = true
        backView.layer.cornerRadius = 12
        backView.layer.borderWidth = 0

        layer.shadowColor = UIColor(red: 0.637, green: 0.637, blue: 0.637, alpha: 0.25).cgColor
        layer.masksToBounds = false
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: -2, height: 2)
        layer.shadowRadius = 8
    }
}
