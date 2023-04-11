//
//  MoreFitWellV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import Then
import SnapKit

class MoreFitWellV: UIView {
    lazy var headerView = PlainHeaderView().then {
        $0.isHiddenRefreshButton = true
        $0.headerType = .fitWell
    }
    
    lazy var counselorList: UITableView = UITableView().then {
        $0.register(MoreFitWellCell.self, forCellReuseIdentifier: MoreFitWellCell.cellID)
        $0.showsVerticalScrollIndicator = false
        $0.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }

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
