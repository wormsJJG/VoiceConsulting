//
//  Extension+UICollectionView.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/15.
//

import UIKit
import SnapKit
import Then

extension UICollectionView {
    
    func setEmptyView(in message: String) {
        
        let emptyView: UIView = UIView().then {
            
            $0.frame = CGRect(x: self.center.x, y: self.center.y, width: self.bounds.width, height: self.bounds.height)
        }
        
        let messageLabel: UILabel = UILabel().then {
            
            $0.text = message
            $0.textColor = ColorSet.subTextColor2
            $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
            $0.numberOfLines = 0
        }
        
        emptyView.addSubview(messageLabel)
        
        messageLabel.snp.makeConstraints {
            
            $0.center.equalTo(emptyView.snp.center)
        }
        
        self.backgroundView = emptyView
    }
    
    func restore() {
        
        self.backgroundView = nil
    }
}
