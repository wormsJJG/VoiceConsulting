//
//  TapViewCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/20.
//

import UIKit
import SnapKit
import Then

class TapViewCell: UITableViewCell {
    static let cellID = "tapViewCell"
    
    let tapView: CustomTabBar = CustomTabBar().then {
        $0.selectItem = .introduce
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.contentView.addSubview(tapView)
        
        tapView.snp.makeConstraints {
            $0.height.equalTo(43)
            $0.edges.equalTo(self.contentView.snp.edges)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tapView.selectItem = .introduce
    }
}
