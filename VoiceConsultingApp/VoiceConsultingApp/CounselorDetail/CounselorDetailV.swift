//
//  CounselorDetailV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/29.
//

import UIKit
import Then
import SnapKit
import PureLayout

class CounselorDetailV: UIView {
    let header: CounselorDetailHeader = CounselorDetailHeader()
    var heightC: NSLayoutConstraint!
    
    lazy var scrollView: UIScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
    }
    
    lazy var contentView: UIView = UIView()
    
    let startConsultButton: UIButton = UIButton().then {
        $0.backgroundColor = ColorSet.mainColor
        $0.setTitle("상담하기", for: .normal)
        $0.titleLabel?.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
    }
    
    let profileimage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.thumnail)
    }
    
    let counselorName: UILabel = UILabel().then {
        $0.text = "김이름 상담사"
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 16)
        $0.textColor = ColorSet.mainText
    }
    
    private lazy var topStackView: UIStackView = UIStackView(arrangedSubviews: [profileimage, counselorName]).then {
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .center
    }
    
    let introduce: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textColor = ColorSet.subTextColor
        $0.numberOfLines = 0
        $0.text = "소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개"
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [topStackView, introduce]).then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.alignment = .leading
    }
    
    let tapView: CustomTabBar = CustomTabBar().then {
        $0.selectItem = .introduce
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let stikyTapView: CustomTabBar = CustomTabBar().then {
        $0.selectItem = .introduce
        $0.isHidden = true
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    lazy var infoList: UITableView = UITableView().then {
        $0.register(InfoSectionHeader.self, forHeaderFooterViewReuseIdentifier: InfoSectionHeader.headerID)
        $0.register(AffiliationCell.self, forCellReuseIdentifier: AffiliationCell.cellID)
        $0.register(CertificateCell.self, forCellReuseIdentifier: CertificateCell.cellID)
        $0.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.cellID)
        $0.showsVerticalScrollIndicator = false
        $0.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
        heightC = infoList.autoSetDimension(.height, toSize: 20)
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
        
        self.addSubview(scrollView)
        
        self.scrollView.snp.makeConstraints { scrollView in
            scrollView.left.equalTo(self.snp.left)
            scrollView.top.equalTo(self.header.snp.bottom)
            scrollView.right.equalTo(self.snp.right)
            scrollView.bottom.equalTo(self.startConsultButton.snp.top).offset(-10)
        }
        
        self.scrollView.addSubview(contentView)
        
        self.contentView.snp.makeConstraints { contentView in
            contentView.edges.equalTo(self.scrollView.snp.edges)
            contentView.width.equalTo(self.scrollView.snp.width)
        }
        
        self.contentView.addSubview(allStackView)
        
        profileimage.snp.makeConstraints {
            $0.width.height.equalTo(50)
        }
        
        self.allStackView.snp.makeConstraints {
            $0.left.equalTo(self.contentView.snp.left).offset(20)
            $0.top.equalTo(self.contentView.snp.top).offset(20)
            $0.right.equalTo(self.contentView.snp.right).offset(-20)
        }
        
        self.contentView.addSubview(tapView)
            
        self.tapView.snp.makeConstraints {
            $0.height.equalTo(43)
            $0.left.equalTo(self.contentView.snp.left)
            $0.top.equalTo(self.allStackView.snp.bottom).offset(20)
            $0.right.equalTo(self.contentView.snp.right)
        }
        
        self.contentView.addSubview(infoList)
        
        self.infoList.snp.makeConstraints {
            $0.left.equalTo(self.contentView.snp.left)
            $0.top.equalTo(self.tapView.snp.bottom)
            $0.right.equalTo(self.contentView.snp.right)
            $0.bottom.equalTo(self.contentView.snp.bottom)
        }
        
        self.contentView.addSubview(stikyTapView)
        
        stikyTapView.snp.makeConstraints {
            $0.height.equalTo(43)
            $0.top.equalTo(self.header.snp.bottom)
            $0.left.equalTo(self.contentView.snp.left)
            $0.right.equalTo(self.contentView.snp.right)
        }
    }
}
