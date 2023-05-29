//
//  MyPageV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import Then
import SnapKit

class MyPageV: UIView {
    // MARK: - View
    lazy var header = MyPageHeader()
    
    lazy var profileImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.thumnail)
        $0.layer.cornerRadius = 30.0
    }
    
    lazy var name: UILabel = UILabel().then {
        $0.text = "박고민"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 16)
    }
    
    let userTypeView: UserTypeView = UserTypeView().then {
        $0.isUser = true
    }
    
    private lazy var nameUserTypeStackView: UIStackView = UIStackView(arrangedSubviews: [userTypeView, name]).then {
        $0.axis = .vertical
        $0.spacing = 6
    }
    
    private lazy var profileStackView: UIStackView = UIStackView(arrangedSubviews: [profileImage, nameUserTypeStackView]).then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.alignment = .center
    }
    
    lazy var coinBlock = BigCoinBlock()
    
    private let line = UIView().then {
        $0.backgroundColor = ColorSet.line
    }
    
    lazy var menuList: UITableView = UITableView().then {
        $0.register(MenuCell.self, forCellReuseIdentifier: MenuCell.cellID)
        $0.separatorStyle = .none
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var serviceCenter = ServiceCenterBlock()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Constraint
    private func constraint() {
        self.addSubview(header)
        
        self.header.snp.makeConstraints { hv in
            hv.left.equalTo(self.snp.left)
            hv.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            hv.right.equalTo(self.snp.right)
        }
        
        self.profileImage.snp.makeConstraints { image in
            image.width.height.equalTo(60)
        }
        
        self.addSubview(profileStackView)
        
        self.profileStackView.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(20)
            $0.top.equalTo(self.header.snp.bottom).offset(20)
        }
        
        self.addSubview(coinBlock)
        
        self.coinBlock.snp.makeConstraints { cb in
            cb.height.equalTo(50)
            cb.left.equalTo(self.snp.left).offset(20)
            cb.top.equalTo(self.profileStackView.snp.bottom).offset(23)
            cb.right.equalTo(self.snp.right).offset(-20)
        }
        
        self.addSubview(line)
        
        line.snp.makeConstraints {
            $0.height.equalTo(6)
            $0.left.equalTo(self.snp.left)
            $0.top.equalTo(self.coinBlock.snp.bottom).offset(23)
            $0.right.equalTo(self.snp.right)
        }
        
        self.addSubview(serviceCenter)
        
        self.serviceCenter.snp.makeConstraints { block in
            block.height.equalTo(50)
            block.left.equalTo(self.snp.left).offset(20)
            block.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            block.right.equalTo(self.snp.right).offset(-20)
        }
        
        self.addSubview(menuList)
        
        self.menuList.snp.makeConstraints { list in
            list.left.equalTo(self.snp.left)
            list.top.equalTo(self.line.snp.bottom)
            list.right.equalTo(self.snp.right)
            list.bottom.equalTo(self.serviceCenter.snp.top).offset(-20)
        }
    }
}
