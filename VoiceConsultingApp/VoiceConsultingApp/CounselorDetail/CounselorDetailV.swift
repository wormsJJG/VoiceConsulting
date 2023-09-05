//
//  CounselorDetailV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/29.
//

import UIKit
import Then
import SnapKit

class CounselorDetailV: UIView {
    let header: CounselorDetailHeader = CounselorDetailHeader()
    
    let startConsultButton: PlainButton = PlainButton().then {
        
        $0.titleText = "상담하기"
    }
    
    let stikyTapView: CustomTabBar = CustomTabBar().then {
        $0.selectItem = .introduce
        $0.isHidden = true
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var infoList: UITableView = UITableView().then {
        $0.register(CategoryTVCell.self, forCellReuseIdentifier: CategoryTVCell.cellID)
        $0.register(ProfileCell.self, forCellReuseIdentifier: ProfileCell.cellID)
        $0.register(TapViewCell.self, forCellReuseIdentifier: TapViewCell.cellID)
        $0.register(InfoSectionHeader.self, forHeaderFooterViewReuseIdentifier: InfoSectionHeader.headerID)
        $0.register(AffiliationCell.self, forCellReuseIdentifier: AffiliationCell.cellID)
        $0.register(CertificateCell.self, forCellReuseIdentifier: CertificateCell.cellID)
        $0.register(DetailIntrodutionCell.self, forCellReuseIdentifier: DetailIntrodutionCell.cellID)
        $0.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.cellID)
        $0.showsVerticalScrollIndicator = false
        $0.separatorStyle = .none
        $0.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        self.addSubview(header)
        
        header.snp.makeConstraints {
            $0.left.equalTo(self.snp.left)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.right.equalTo(self.snp.right)
        }
        
        self.addSubview(startConsultButton)
        
        startConsultButton.snp.makeConstraints {
            $0.height.equalTo(54)
            $0.left.equalTo(self.snp.left).offset(20)
            $0.right.equalTo(self.snp.right).offset(-20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
        self.addSubview(infoList)
        
        self.infoList.snp.makeConstraints {
            $0.left.equalTo(self.snp.left)
            $0.top.equalTo(self.header.snp.bottom)
            $0.right.equalTo(self.snp.right)
            $0.bottom.equalTo(self.startConsultButton.snp.top).offset(-10)
        }
        
        self.addSubview(stikyTapView)

        stikyTapView.snp.makeConstraints {
            $0.height.equalTo(43)
            $0.top.equalTo(self.header.snp.bottom)
            $0.left.equalTo(self.snp.left)
            $0.right.equalTo(self.snp.right)
        }
    }
}
