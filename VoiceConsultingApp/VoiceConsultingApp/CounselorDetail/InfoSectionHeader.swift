//
//  SectionHeader.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/07.
//

import UIKit
import SnapKit
import Then

class InfoSectionHeader: UITableViewHeaderFooterView {
    static let headerID = "infoSectionHeader"
    
    var sectionTitle: String = "제목" {
        didSet {
            self.sectionTitleLabel.text = sectionTitle
        }
    }
    
    private lazy var sectionTitleLabel: UILabel = UILabel().then {
        $0.text = self.sectionTitle
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addSubview(sectionTitleLabel)
        
        self.sectionTitleLabel.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(20)
            $0.centerY.equalTo(self.snp.centerY)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
