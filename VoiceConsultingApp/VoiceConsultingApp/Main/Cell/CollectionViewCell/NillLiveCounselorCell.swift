//
//  NillLiveCounselorCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/10.
//

import UIKit
import SnapKit
import Then

class NillLiveCounselorCell: UICollectionViewCell {
    static let cellID = "NillLiveCounselorCell"
    
    private let infomationLabel: UILabel = UILabel().then {
        $0.text = "현재 가능한 상담사가 없습니다.\n잠시 후 다시 시도해주세요."
        $0.textColor = ColorSet.subTextColor2
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(infomationLabel)
        
        infomationLabel.snp.makeConstraints {
            $0.center.equalTo(self.contentView.snp.center)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
