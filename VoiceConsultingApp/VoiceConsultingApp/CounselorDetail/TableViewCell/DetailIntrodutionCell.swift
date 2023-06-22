//
//  DetailIntrodutionCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/19.
//

import UIKit
import Then
import SnapKit

class DetailIntrodutionCell: UITableViewCell {
    static let cellID = "detailIntroducationCell"
    
    let detailIntrodutionLabel: UILabel = UILabel().then {
        $0.text = "소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 14)
        $0.numberOfLines = 0
    }
    
    private let line = UIView().then {
        $0.backgroundColor = ColorSet.line
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(line)
        
        self.line.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.left.equalTo(self.contentView.snp.left).offset(20)
            $0.bottom.equalTo(self.contentView.snp.bottom)
            $0.right.equalTo(self.contentView.snp.right).offset(-20)
        }
        
        self.contentView.addSubview(detailIntrodutionLabel)
        
        detailIntrodutionLabel.snp.makeConstraints {
            $0.top.equalTo(self.contentView.snp.top).offset(10)
            $0.left.equalTo(self.contentView.snp.left).offset(20)
            $0.right.equalTo(self.contentView.snp.right).offset(-20)
            $0.bottom.equalTo(self.line.snp.top).offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(in introdution: String) {
        
        detailIntrodutionLabel.text = introdution
    }
}
