//
//  CategoryBlock.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/06.
//

import UIKit
import SnapKit
import Then

class CategoryBlock: UIView {
    lazy var label: UILabel = UILabel().then {
        $0.text = "가족상담"
        $0.textColor = ColorSet.mainColor
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
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1
        self.layer.borderColor = ColorSet.mainColor?.cgColor
    }
    
    private func constraint() {
        self.addSubview(label)
        
        label.snp.makeConstraints { label in
            label.center.equalTo(self.snp.center)
        }
    }
}
