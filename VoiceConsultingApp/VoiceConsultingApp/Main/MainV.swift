//
//  MainV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/26.
//

import UIKit
import Then
import SnapKit

class MainV: UIView {
    
    lazy var headerView = MainHeaderView()
    
    lazy var bannerImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.bannerImage)
    }
    
    lazy var mainList: UITableView = UITableView().then {
        $0.register(BannerCell.self, forCellReuseIdentifier: BannerCell.cellID)
        $0.register(LiveCell.self, forCellReuseIdentifier: LiveCell.cellID)
        $0.register(PopularCell.self, forCellReuseIdentifier: PopularCell.cellID)
        $0.register(FitWellCell.self, forCellReuseIdentifier: FitWellCell.cellID)
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    private func constraint() {
        self.addSubview(headerView)
        
        self.headerView.snp.makeConstraints { hv in
            hv.left.equalTo(self.snp.left)
            hv.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            hv.right.equalTo(self.snp.right)
        }
        
        self.addSubview(mainList)
        
        self.mainList.snp.makeConstraints { list in
            list.top.equalTo(self.headerView.snp.bottom)
            list.left.equalTo(self.snp.left)
            list.right.equalTo(self.snp.right)
            list.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
