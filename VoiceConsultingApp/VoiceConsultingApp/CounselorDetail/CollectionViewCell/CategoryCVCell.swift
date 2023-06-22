//
//  CategoryCVCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/20.
//

import UIKit
import Then
import SnapKit

class CategoryCVCell: UICollectionViewCell {
    static let cellID = "CategoryCVCell"
    
    let categoryLabel: UILabel = UILabel().then {
        $0.text = "가족상담"
        $0.textColor = ColorSet.mainColor
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = ColorSet.mainColor!.cgColor
        self.contentView.layer.cornerRadius = 4
        
        self.contentView.addSubview(categoryLabel)
        
        self.categoryLabel.snp.makeConstraints {
            $0.left.equalTo(self.contentView.snp.left).offset(10)
            $0.top.equalTo(self.contentView.snp.top).offset(6)
            $0.right.equalTo(self.contentView.snp.right).offset(-10)
            $0.bottom.equalTo(self.contentView.snp.bottom).offset(-6)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(in category: String) {
        
        self.categoryLabel.text = category
    }
}
