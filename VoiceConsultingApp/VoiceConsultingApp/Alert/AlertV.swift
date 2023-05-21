//
//  AlertV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/21.
//

import UIKit
import Then
import SnapKit

class AlertV: UIView {
    lazy var headerView = PlainHeaderView().then {
        $0.isHiddenRefreshButton = true
        $0.headerType = .alert
    }
    
    lazy var alertList: UITableView = UITableView().then {
        $0.register(AlertContentCell.self, forCellReuseIdentifier: AlertContentCell.cellID)
        $0.showsVerticalScrollIndicator = false
        $0.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
        
        headerView.snp.makeConstraints {
            $0.left.equalTo(self.snp.left)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.right.equalTo(self.snp.right)
        }
        
        self.addSubview(alertList)
        
        alertList.snp.makeConstraints {
            $0.left.equalTo(self.snp.left)
            $0.top.equalTo(self.headerView.snp.bottom)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.snp.bottom)
        }
    }
    
}
