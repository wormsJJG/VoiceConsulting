//
//  MoreLiveV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import Then
import SnapKit

class MoreLiveV: UIView {
    lazy var headerView = MoreHeaderView().then {
        $0.moreType = .live
    }
    
    lazy var counselorList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 30, height: 164)
        layout.minimumLineSpacing = 20.0
        
        let list = UICollectionView(frame: .zero, collectionViewLayout: layout)
        list.register(LiveCounselorCell.self, forCellWithReuseIdentifier: LiveCounselorCell.cellID)
        list.showsVerticalScrollIndicator = false
        
        return list
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        self.addSubview(headerView)
        
        self.headerView.snp.makeConstraints { hv in
            hv.left.equalTo(self.snp.left)
            hv.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            hv.right.equalTo(self.snp.right)
        }
        
        self.addSubview(counselorList)
        
        self.counselorList.snp.makeConstraints { list in
            list.left.equalTo(self.snp.left)
            list.top.equalTo(self.headerView.snp.bottom)
            list.right.equalTo(self.snp.right)
            list.bottom.equalTo(self.snp.bottom)
        }
    }
}
