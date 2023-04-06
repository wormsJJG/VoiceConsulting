//
//  CounselorBadge.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/06.
//

import UIKit
import Then
import SnapKit

class CounselorBadge: UIView {
    lazy var label: UILabel = UILabel().then {
        $0.text = "상담사뱃지"
        $0.textColor = .white
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 12)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewDesign()
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func viewDesign() {
        self.backgroundColor = ColorSet.mainColor
    }
    
    private func constraint() {
        self.addSubview(label)
        
        label.snp.makeConstraints { label in
            label.center.equalTo(self.snp.center)
        }
    }
}
