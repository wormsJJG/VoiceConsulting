//
//  PopularCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/03.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class PopularCell: UITableViewCell {
    static let cellID: String = "popularCell"
    // MARK: - View
    lazy var header: MainListHeader = MainListHeader().then {
        $0.refreshButton.isHidden = true
    }
    
    lazy var counselorList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 40, height: 220)
        layout.minimumLineSpacing = 10.0
        
        let list = UICollectionView(frame: .zero, collectionViewLayout: layout)
        list.register(PopularCounselorCell.self, forCellWithReuseIdentifier: PopularCounselorCell.cellID)
        list.showsHorizontalScrollIndicator = false
        
        return list
    }()
    // MARK: - Properties
    let popularCounselorList: PublishSubject<[String]> = PublishSubject()
    private let disposeBag = DisposeBag()
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        constraint()
        dataBind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func constraint() {
        self.contentView.addSubview(header)
        
        self.header.snp.makeConstraints { header in
            header.left.equalTo(self.contentView.snp.left)
            header.top.equalTo(self.contentView.snp.top)
            header.right.equalTo(self.contentView.snp.right)
        }
        
        self.contentView.addSubview(counselorList)
        
        self.counselorList.snp.makeConstraints { list in
            list.height.equalTo(240)
            list.left.equalTo(self.contentView.snp.left)
            list.top.equalTo(self.header.snp.bottom)
            list.right.equalTo(self.contentView.snp.right)
            list.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
        }
    }
    
    private func dataBind() {
        self.popularCounselorList
            .bind(to: counselorList.rx.items(cellIdentifier: PopularCounselorCell.cellID, cellType: PopularCounselorCell.self)) { index, counselor, cell in
            }
            .disposed(by: self.disposeBag)
    }
}
