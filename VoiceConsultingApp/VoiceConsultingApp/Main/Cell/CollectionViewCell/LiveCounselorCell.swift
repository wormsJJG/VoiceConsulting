//
//  LiveCounselorCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/04.
//

import UIKit
import Then
import SnapKit

class LiveCounselorCell: UICollectionViewCell {
    static let cellID = "liveCounselorCell"
    // MARK: - View
    lazy var thumnail: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.thumnail)
        $0.layer.cornerRadius = 30
    }
    
    lazy var name: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textColor = ColorSet.mainText
        $0.text = "김이름 상담사"
    }
    
    lazy var contentStackView: UIStackView = UIStackView(arrangedSubviews: [thumnail, name]).then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fillProportionally
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellDesign()
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellDesign() {
        setViewShadow(backView: contentView)
        self.contentView.layoutIfNeeded()
    }
    
    private func constraint() {
        self.contentView.addSubview(contentStackView)
        
        self.thumnail.snp.makeConstraints { image in
            image.width.height.equalTo(60)
        }
        
        self.contentStackView.snp.makeConstraints { sv in
            sv.center.equalTo(self.contentView.snp.center)
        }
    }
}
