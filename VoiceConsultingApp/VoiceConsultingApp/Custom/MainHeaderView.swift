//
//  MainHeaderView.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/03.
//

import UIKit
import SnapKit

class MainHeaderView: UIView {
    lazy var coinBlock: CoinBlock = CoinBlock()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        MHCDesign()
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func MHCDesign() {
        self.snp.makeConstraints { hv in
            hv.height.equalTo(54)
        }
    }
    
    private func constraint() {
        self.addSubview(coinBlock)
        
        self.coinBlock.snp.makeConstraints { view in
            view.top.equalTo(self.snp.top).offset(9)
            view.right.equalTo(self.snp.right).offset(-20)
            view.bottom.equalTo(self.snp.bottom).offset(-9)
        }
    }
}
