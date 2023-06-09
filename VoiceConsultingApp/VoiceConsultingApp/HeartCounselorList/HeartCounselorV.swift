//
//  HeartCounselorV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/22.
//

import UIKit
import Then
import SnapKit

class HeartCounselorV: UIView {
    let headerView: PlainHeaderView = PlainHeaderView().then {
        $0.headerType = .heartCounselor
        $0.isHiddenRefreshButton = true
    }
    
    lazy var counselorList: UITableView = UITableView().then {
        $0.register(HeartCounselorCell.self, forCellReuseIdentifier: HeartCounselorCell.cellID)
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
        
        headerView.snp.makeConstraints {
            $0.left.equalTo(self.snp.left)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.right.equalTo(self.snp.right)
        }
        
        self.addSubview(counselorList)
        
        counselorList.snp.makeConstraints {
            $0.left.equalTo(self.snp.left)
            $0.top.equalTo(self.headerView.snp.bottom)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.snp.bottom)
        }
    }
}
