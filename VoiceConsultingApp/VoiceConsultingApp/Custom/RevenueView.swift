//
//  RevenueBlock.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/31.
//

import UIKit
import Then
import SnapKit

class RevenueView: UIView {
    
    private let titlelabel: UILabel = UILabel().then {
        
        $0.text = "보유코인"
        $0.textColor = ColorSet.subTextColor
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textAlignment = .center
    }
    
    private let coinCountlabel: UILabel = UILabel().then {
        
        $0.text = "400"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.Inter_Bold, size: 30)
        $0.textAlignment = .center
    }
    
    private lazy var topStackView: UIStackView = UIStackView(arrangedSubviews: [titlelabel, coinCountlabel]).then {
        
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private let lineView: UIView = UIView().then {
        
        $0.backgroundColor = ColorSet.line
    }
    
    private let infolabel: UILabel = UILabel().then {
        
        $0.text = "정산 관련 정책, 세금 처리 관련은\n고객센터로 문의주세요."
        $0.textColor = ColorSet.subTextColor
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    private let serviceCenterView: MiniServiceCenterView = MiniServiceCenterView()
    
    private lazy var bottomStackView: UIStackView = UIStackView(arrangedSubviews: [infolabel, serviceCenterView]).then {
        
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [topStackView, lineView, bottomStackView]).then {
        
        $0.axis = .vertical
        $0.spacing = 20
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = ColorSet.line?.cgColor
        self.layer.cornerRadius = 20
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraints() {
        
        lineView.snp.makeConstraints {
            
            $0.height.equalTo(1)
        }
        
        serviceCenterView.snp.makeConstraints {
            
            $0.height.equalTo(33)
        }
        
        addSubview(allStackView)
        
        allStackView.snp.makeConstraints {
            
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
    }
}
