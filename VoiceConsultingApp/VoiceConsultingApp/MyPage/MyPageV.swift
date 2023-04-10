//
//  MyPageV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import Then
import SnapKit

class MyPageV: UIView {
    // MARK: - View
    lazy var header = MyPageHeader()
    
    lazy var coinBlock = BigCoinBlock()
    
    private lazy var serviceCenter = ServiceCenterBlock()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Constraint
    private func constraint() {
        self.addSubview(header)
        
        self.header.snp.makeConstraints { hv in
            hv.left.equalTo(self.snp.left)
            hv.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            hv.right.equalTo(self.snp.right)
        }
        
        self.addSubview(coinBlock)
        
        self.coinBlock.snp.makeConstraints { cb in
            cb.height.equalTo(50)
            cb.left.equalTo(self.snp.left).offset(20)
            cb.top.equalTo(self.header.snp.bottom).offset(20)
            cb.right.equalTo(self.snp.right).offset(-20)
        }
        
        self.addSubview(serviceCenter)
        
        self.serviceCenter.snp.makeConstraints { block in
            block.height.equalTo(50)
            block.left.equalTo(self.snp.left).offset(20)
            block.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            block.right.equalTo(self.snp.right).offset(-20)
        }
    }
}
