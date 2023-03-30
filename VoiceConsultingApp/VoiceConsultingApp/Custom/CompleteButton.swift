//
//  CompleteButton.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/30.
//

import UIKit

class CompleteButton: UIButton {
    var titleText: String?
    
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
            self.setTitleColor(.white, for: .normal)
            self.layer.backgroundColor = ColorSet.mainColor?.cgColor
            self.layer.cornerRadius = 10
        }
    }

}
