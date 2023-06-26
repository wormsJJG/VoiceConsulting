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
            
            $0.edges.equalTo(contentView.snp.edges).inset(UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(in affiliation: String) {
            
        self.affiliationLabel.text = affiliation
    }
}
