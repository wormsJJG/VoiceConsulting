//
//  LiveCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/03.
//

import UIKit
import Then
import SnapKit
import RxCocoa
import RxSwift

class LiveCell: UITableViewCell {
    static let cellID: String = "liveCell"
    // MARK: - View
    lazy var header: MainListHeader = MainListHeader()
    
    lazy var counselorList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 3) + 10, height: 140)
        layout.minimumLineSpacing = 10.0
        
        let list = UICollectionView(frame: .zero, collectionViewLayout: layout)
        list.register(LiveCounselorCell.self, forCellWithReuseIdentifier: LiveCounselorCell.cellID)
        list.showsHorizontalScrollIndicator = false
        
        return list
    }()
    // MARK: - Properties
    let onlineCounselorList: PublishSubject<[Counselor]> = PublishSubject()
    private let disposeBag = DisposeBag()
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        constraint()
        bindCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: - Constraint
    private func constraint() {
        self.contentView.addSubview(header)
        
        self.header.snp.makeConstraints { header in
            header.left.equalTo(self.contentView.snp.left)
            header.top.equalTo(self.contentView.snp.top)
            header.right.equalTo(self.contentView.snp.right)
        }
        
        self.contentView.addSubview(counselorList)
        
        self.counselorList.snp.makeConstraints { list in
            list.height.equalTo(170)
            list.left.equalTo(self.contentView.snp.left)
            list.top.equalTo(self.header.snp.bottom)
            list.right.equalTo(self.contentView.snp.right)
            list.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
        }
    }
}
    // MARK: - Data bind
extension LiveCell: UICollectionViewDelegate {
    private func bindCollectionView() {
        self.onlineCounselorList
            .bind(to: counselorList.rx.items(cellIdentifier: LiveCounselorCell.cellID, cellType: LiveCounselorCell.self)) { [weak self] index, counselor, cell in
                cell.configureCell(counselor: counselor.info)
            }
            .disposed(by: self.disposeBag)
        
        self.counselorList.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
        
        self.counselorList.rx.modelSelected(Counselor.self)
            .bind(onNext: { [weak self] counselor in
                NotificationCenter.default.post(name: NotificationName.touchCounselorCell, object: nil, userInfo: ["counselor": counselor])
            })
            .disposed(by: self.disposeBag)
    }
}
