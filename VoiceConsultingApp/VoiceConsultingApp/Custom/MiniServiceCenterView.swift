//
//  MiniServiceCenterView.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/31.
//

import UIKit
import Then
import SnapKit

class MiniServiceCenterView: UIView {

    private lazy var title: UILabel = UILabel().then {
        $0.text = "고객센터"
        $0.textColor = ColorSet.mainColor
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 12)
    }
    
    private lazy var icon: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.phoneIconMainColor)
    }
    
    private lazy var phoneNumber: UILabel = UILabel().then {
        $0.text = CompanyData.ServiceCenterPhoneNumber
        $0.textColor = ColorSet.mainColor
        $0.font = UIFont(name: Fonts.Inter_Medium, size: 14)
    }
    
    private lazy var rightStackView: UIStackView = UIStackView(arrangedSubviews: [icon, phoneNumber]).then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.alignment = .center
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [title, rightStackView]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 16.5
        backgroundColor = ColorSet.requestLabelBack
        
        addSubview(allStackView)
        
        allStackView.snp.makeConstraints {
            
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
