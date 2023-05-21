//
//  AlertContentCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/21.
//

import UIKit
import Then
import SnapKit

class AlertContentCell: UITableViewCell {
    static let cellID = "AlertContentCell"
    
    private let contentLabel: UILabel = UILabel().then {
        $0.text = "알림내용알림내용알림내용알림내용알림내용알림내용알림내용알림내용알림내용알림내용알림내용알림내용알림내용알림내용알림내용알림내용알림내용알림내용"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textColor = ColorSet.mainText
        $0.numberOfLines = 2
    }
    
    private let dateLabel: UILabel = UILabel().then {
        $0.text = "2023.02.22"
        $0.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 12)
        $0.textColor = ColorSet.date
        $0.textAlignment = .left
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [contentLabel, dateLabel]).then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .fill
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(allStackView)
        
        allStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
