//
//  AffiliationContentCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/07.
//

import UIKit
import Then
import SnapKit

class AffiliationContentCell: UICollectionViewCell {
    static let cellID = "affiliationContent"
    
    let affiliationLabel: UILabel = UILabel().then {
        $0.text = "소속기관명"
        $0.textColor = ColorSet.subTextColor
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = ColorSet.line
        self.contentView.layer.cornerRadius = 4
        
        self.contentView.addSubview(affiliationLabel)
        
        self.affiliationLabel.snp.makeConstraints {
            $0.left.equalTo(self.contentView.snp.left).offset(10)
            $0.top.equalTo(self.contentView.snp.top).offset(6)
            $0.right.equalTo(self.contentView.snp.right).offset(-10)
            $0.bottom.equalTo(self.contentView.snp.bottom).offset(-6)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
