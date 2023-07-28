//
//  CertificateCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/07.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

class CertificateCell: UITableViewCell {
    static let cellID = "certificate"
    
    let certificateImageList: PublishSubject<[String]> = PublishSubject()
    private let disposeBag = DisposeBag()
    
    let widthHeight = (UIScreen.main.bounds.width / 3) - 20
    
    private lazy var contentList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: widthHeight, height: widthHeight)
        layout.minimumLineSpacing = 10.0
        
        let list = UICollectionView(frame: .zero, collectionViewLayout: layout)
        list.register(CertificateContentCell.self, forCellWithReuseIdentifier: CertificateContentCell.cellID)
        list.showsHorizontalScrollIndicator = false
        
        return list
    }()
    
    private let line = UIView().then {
        $0.backgroundColor = ColorSet.line
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.contentView.addSubview(line)
        
        self.line.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.equalTo(self.contentView.snp.left).offset(20)
            $0.bottom.equalTo(self.contentView.snp.bottom)
            $0.right.equalTo(self.contentView.snp.right).offset(-20)
        }
        
        self.contentView.addSubview(contentList)
        
        self.contentList.snp.makeConstraints {
            $0.height.equalTo(widthHeight)
            $0.left.equalTo(self.contentView.snp.left)
            $0.top.equalTo(self.contentView.snp.top).offset(10)
            $0.right.equalTo(self.contentView.snp.right)
            $0.bottom.equalTo(self.line.snp.bottom).offset(-20)
        }
        bindList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindList() {
        self.certificateImageList.bind(to: self.contentList.rx.items(cellIdentifier: CertificateContentCell.cellID, cellType: CertificateContentCell.self)) { [weak self] index, certificateImageUrl, cell in
            
            cell.configureCell(in: certificateImageUrl)
        }
        .disposed(by: self.disposeBag)
    }
}
