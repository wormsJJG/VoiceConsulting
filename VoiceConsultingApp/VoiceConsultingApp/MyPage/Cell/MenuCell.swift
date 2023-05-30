//
//  MenuCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import UIKit
import Then
import SnapKit

class MenuCell: UITableViewCell {
    static let cellID = "MenuCell"
    
    private lazy var title: UILabel = UILabel().then {
        $0.text = "Title"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 16)
    }
    
    lazy var toggle: UISwitch = UISwitch().then {
        $0.onTintColor = ColorSet.mainColor
        $0.isHidden = true
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        self.contentView.addSubview(title)
        
        self.title.snp.makeConstraints { label in
            label.left.equalTo(self.contentView.snp.left).offset(20)
            label.top.equalTo(self.contentView.snp.top).offset(15)
            label.bottom.equalTo(self.contentView.snp.bottom).offset(-15)
        }
        
        self.contentView.addSubview(toggle)
        
        self.toggle.snp.makeConstraints { toggle in            
            toggle.right.equalTo(self.contentView.snp.right).offset(-20)
            toggle.centerY.equalTo(self.contentView.snp.centerY)
        }
    }
    
    func configure(menuType: MypageMenu) {
        self.title.text = menuType.title
        
        if menuType == .alarmOnOff {
            self.toggle.isHidden = false
        } else if menuType == .logOut {
            self.title.textColor = ColorSet.subTextColor
        } else if menuType == .outOfService {
            self.title.textColor = ColorSet.date
            self.title.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
            self.title.attributedText = NSMutableAttributedString(string: "회원탈퇴", attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.kern: -1])
        }
    }
}
