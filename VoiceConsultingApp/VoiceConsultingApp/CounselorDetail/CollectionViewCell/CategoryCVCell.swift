//
//  CategoryCVCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/20.
//

import UIKit
import Then
import SnapKit
import RxSwift

class CategoryCVCell: UICollectionViewCell {
    static let cellID = "CategoryCVCell"
    private let disposeBag = DisposeBag()
    
    let categoryLabel: UILabel = UILabel().then {
        $0.text = "카테고리"
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
            
            $0.edges.equalTo(contentView.snp.edges).inset(UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(in categoryName: String) {

        self.categoryLabel.text = categoryName
    }
}
