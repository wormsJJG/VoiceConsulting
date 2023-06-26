//
//  CategoryTVCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/20.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class CategoryTVCell: UITableViewCell {
    static let cellID = "CategoryTVCell"
    
    let categoryList: PublishSubject<[String]> = PublishSubject()
    private let disposeBag = DisposeBag()
    
    private let categoryCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout()).then {
        $0.register(CategoryCVCell.self, forCellWithReuseIdentifier: CategoryCVCell.cellID)
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let line = UIView().then {
        $0.backgroundColor = ColorSet.line
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        if let flowLayout = categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        self.contentView.addSubview(categoryCollectionView)
        
        self.contentView.addSubview(line)
        
        self.line.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.equalTo(self.contentView.snp.left).offset(20)
            $0.bottom.equalTo(self.contentView.snp.bottom)
            $0.right.equalTo(self.contentView.snp.right).offset(-20)
        }
        
        self.categoryCollectionView.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.left.equalTo(self.contentView.snp.left)
            $0.top.equalTo(self.contentView.snp.top).offset(3)
            $0.right.equalTo(self.contentView.snp.right)
            $0.bottom.equalTo(self.line.snp.bottom).offset(-11)
        }
        
        bindList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindList() {
        self.categoryList.bind(to: self.categoryCollectionView.rx.items(cellIdentifier: CategoryCVCell.cellID, cellType: CategoryCVCell.self)) { [weak self] index, categoryId, cell in
            
            cell.configureCell(in: CategoryManager.shared.convertIdToName(in: categoryId))
        }
        .disposed(by: self.disposeBag)
    }
}
