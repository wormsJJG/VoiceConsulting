//
//  MoreHeaderView.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import Then
import SnapKit

class PlainHeaderView: UIView {
    var headerType: HeaderType = .live {
        didSet {
            self.titleLabel.text = headerType.title
        }
    }
    
    var isHiddenRefreshButton: Bool = false {
        didSet {
            if isHiddenRefreshButton {
                refreshButton.setTitleColor(.white, for: .normal)
            }
        }
    }
    
    lazy var backButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: AssetImage.backButton), for: .normal)
        $0.setTitle(nil, for: .normal)
    }
    
    lazy var titleLabel: UILabel = UILabel().then {
        $0.text = ""
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
        $0.textColor = ColorSet.mainText
    }
    
    lazy var refreshButton: UIButton = UIButton().then {
        $0.setTitle("새로고침", for: .normal)
        $0.setTitleColor(ColorSet.subTextColor, for: .normal)
        $0.titleLabel?.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 14)
    }
    
    private lazy var leftStackView: UIStackView = UIStackView(arrangedSubviews: [backButton, titleLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.alignment = .center
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [leftStackView, refreshButton]).then {
        $0.axis = .horizontal
        $0.distribution = .equalCentering
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        self.addSubview(allStackView)
        
        self.allStackView.snp.makeConstraints { sv in
            sv.left.equalTo(self.snp.left).offset(20)
            sv.top.equalTo(self.snp.top).offset(10)
            sv.right.equalTo(self.snp.right).offset(-20)
            sv.bottom.equalTo(self.snp.bottom).offset(-10)
        }
    }
}
