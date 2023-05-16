//
//  CoinManagementV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import UIKit
import Then
import SnapKit

class CoinManagementV: UIView {
    let header = PlainHeaderView().then {
        $0.isHiddenRefreshButton = true
        $0.headerType = .coinManagement
    }
    
    let tapView: UIView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        self.addSubview(header)
        
        self.header.snp.makeConstraints { header in
            header.left.equalTo(self.snp.left)
            header.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            header.right.equalTo(self.snp.right)
        }
        
        self.addSubview(tapView)
        
        self.tapView.snp.makeConstraints { view in
            view.height.equalTo(43)
            
            view.left.equalTo(self.snp.left)
            view.top.equalTo(self.header.snp.bottom)
            view.right.equalTo(self.snp.right)
        }
    }
}
