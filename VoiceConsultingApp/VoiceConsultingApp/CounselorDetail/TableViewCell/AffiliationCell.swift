//
//  AffiliationCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/07.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

class AffiliationCell: UITableViewCell {
    static let cellID = "affiliation"
    
    let affiliationList: PublishSubject<[String]> = PublishSubject()
    private let disposeBag = DisposeBag()
    
    private let contentList: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLeftAlignFlowLayout()).then {
        
        $0.register(AffiliationContentCell.self, forCellWithReuseIdentifier: AffiliationContentCell.cellID)
        $0.showsHorizontalScrollIndicator = false
    }
    
    private let line = UIView().then {
        $0.backgroundColor = ColorSet.line
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        if let flowLayout = contentList.collectionViewLayout as? UICollectionViewFlowLayout {
            
                flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        self.contentView.addSubview(contentList)
        
        self.contentView.addSubview(line)
        
        self.line.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.equalTo(self.contentView.snp.left).offset(20)
            $0.bottom.equalTo(self.contentView.snp.bottom)
            $0.right.equalTo(self.contentView.snp.right).offset(-20)
        }
        
        self.contentList.snp.makeConstraints {
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
        self.affiliationList.bind(to: self.contentList.rx.items(cellIdentifier: AffiliationContentCell.cellID, cellType: AffiliationContentCell.self)) { [weak self] index, affiliation, cell in
            
            cell.configureCell(in: affiliation)
        }
        .disposed(by: self.disposeBag)
    }
}
