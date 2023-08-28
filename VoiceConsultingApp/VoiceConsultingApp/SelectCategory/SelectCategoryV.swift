//
//  SelectCategoryV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/30.
//

import UIKit
import Then
import SnapKit

class SelectCategoryV: UIView {
    private lazy var infomationLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 16)
        $0.text = "카테고리를 선택하세요"
        $0.numberOfLines = 2
        $0.textColor = ColorSet.mainText
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var subInfomationLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.text = "중복선택 가능"
        $0.textColor = ColorSet.mainColor
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var categoryList: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.cellID)
    }
    
    lazy var completeButton: PlainButton = PlainButton().then {
        $0.titleText = "완료하기"
    }
    
    private lazy var labelStackView: UIStackView = UIStackView(arrangedSubviews: [infomationLabel, subInfomationLabel]).then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 8
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        self.addSubview(labelStackView)
        
        self.labelStackView.snp.makeConstraints { stackView in
            stackView.left.equalTo(self.snp.left).offset(20)
            stackView.top.equalTo(self.snp.top).offset(82)
            stackView.right.equalTo(self.snp.right).offset(-20)
        }
        
        self.addSubview(completeButton)
        
        self.completeButton.snp.makeConstraints { button in
            button.height.equalTo(54)
            button.left.equalTo(self.snp.left).offset(20)
            button.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
            button.right.equalTo(self.snp.right).offset(-20)
        }
        
        self.addSubview(self.categoryList)
        
        self.categoryList.snp.makeConstraints { list in
            list.left.equalTo(self.snp.left)
            list.top.equalTo(self.labelStackView.snp.bottom).offset(20)
            list.right.equalTo(self.snp.right)
            list.bottom.equalTo(self.completeButton.snp.top).offset(-10)
        }
    }
}
