//
//  PaddingLabel.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/12.
//

import UIKit

class PaddingLabel: UILabel {
    private var padding = UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6)

    convenience init(padding: UIEdgeInsets) {
        self.init()
        self.padding = padding
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        
        return contentSize
    }

}
