//
//  CategoryCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/31.
//

import UIKit
import Then
import SnapKit

class CategoryCell: UICollectionViewCell {
    static let cellID = "categoryCell"
    
    var isChecked: Bool = false {
        didSet {
            switch isChecked {
            case true:
                checkImage.image = UIImage(named: AssetImage.check_on)
                self.layer.borderColor = ColorSet.mainColor?.cgColor
                self.titleLabel.textColor = ColorSet.mainColor
                self.contentLabel.textColor = ColorSet.mainColor
            case false:
                checkImage.image = UIImage(named: AssetImage.check_off)
                self.layer.borderColor = ColorSet.nonSelectColor?.cgColor
                self.titleLabel.textColor = ColorSet.subTextColor
                self.contentLabel.textColor = ColorSet.subTextColor2
            }
        }
    }
    
    private lazy var checkImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.check_off)
    }
    
    private lazy var titleLabel: UILabel = UILabel().then {
        $0.text = "성인 상담"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
        $0.textColor = ColorSet.subTextColor
    }
    
    private lazy var imageAndLabelSV: UIStackView = UIStackView(arrangedSubviews: [checkImage,
                                                                                   titleLabel]).then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var contentLabel: UILabel = UILabel().then {
        $0.text = "내용"
        $0.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 14)
        $0.textColor = ColorSet.subTextColor2
        $0.numberOfLines = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellDesign()
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(category: CategoryType) {
        self.titleLabel.text = category.categoryNameKr
        self.contentLabel.text = category.categoryDetailKr
        self.layer.cornerRadius = 10
    }
    
    private func cellDesign() {
        self.layer.borderWidth = 1
        self.layer.borderColor = ColorSet.nonSelectColor?.cgColor
    }
    
    private func constraint() {
        self.checkImage.snp.makeConstraints { image in
            image.height.width.equalTo(26)
        }
        
        self.addSubview(imageAndLabelSV)
        
        self.imageAndLabelSV.snp.makeConstraints { stackView in
            stackView.left.equalTo(self.snp.left).offset(16)
            stackView.top.equalTo(self.snp.top).offset(16)
            stackView.right.equalTo(self.snp.right).offset(-16)
        }
        
        self.addSubview(contentLabel)
        
        self.contentLabel.snp.makeConstraints { label in
            label.left.equalTo(self.snp.left).offset(16)
            label.top.equalTo(self.imageAndLabelSV.snp.bottom).offset(10)
            label.right.equalTo(self.snp.right).offset(-16)
            label.bottom.equalTo(self.snp.bottom).offset(-16)
        }
    }
}
