//
//  RevenueManagementV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/28.
//

import UIKit
import SnapKit
import Then
import Tabman
import Pageboy

class RevenueManagementV: UIView {
    
    let header: PlainHeaderView = PlainHeaderView().then {
        
        $0.isHiddenRefreshButton = true
        $0.headerType = .revenueManagement
    }
    
    let revenueView: RevenueView = RevenueView()
    
    let calculateButton: PlainButton = PlainButton().then {
        
        $0.titleText = "정산하기"
    }
    
    lazy var containerView: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraints() {
        
        addSubview(header)
        
        header.snp.makeConstraints {
            
            $0.left.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.right.equalToSuperview()
        }
        
        addSubview(revenueView)
        
        revenueView.snp.makeConstraints {
            
            $0.height.equalTo(240)
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(header.snp.bottom).offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
        
        addSubview(calculateButton)
        
        calculateButton.snp.makeConstraints {
            
            $0.height.equalTo(54)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
        addSubview(containerView)
        
        containerView.snp.makeConstraints {
            
            $0.left.equalToSuperview()
            $0.top.equalTo(revenueView.snp.bottom).offset(20)
            $0.right.equalToSuperview()
            $0.bottom.equalTo(calculateButton.snp.top).offset(-10)
        }
    }
}
