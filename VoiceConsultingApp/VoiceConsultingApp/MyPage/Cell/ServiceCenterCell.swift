//
//  ServiceCenterCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/30.
//

import UIKit
import SnapKit
import Then

class ServiceCenterCell: UITableViewCell {
    static let cellID = "ServiceCenterCell"

    private lazy var serviceCenter = ServiceCenterBlock()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        self.contentView.addSubview(serviceCenter)
        
        self.serviceCenter.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.edges.equalTo(self.contentView.snp.edges).inset(UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
