//
//  TermsV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/22.
//

import UIKit
import SnapKit
import Then

class TermsV: UIView {
    let header: PlainHeaderView = PlainHeaderView().then {
        $0.isHiddenRefreshButton = true
        $0.headerType = .termsOfUse
    }
    
    private lazy var scrollView: UIScrollView = UIScrollView().then {
        $0.backgroundColor = .white
    }
    
    private lazy var contentView: UIView = UIView()
    
    let termsLabel: UILabel = UILabel().then {
        $0.text = TermsContent.termsOfUseContent
        $0.numberOfLines = 0
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(header)
        
        header.snp.makeConstraints {
            $0.left.equalTo(self.snp.left)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.right.equalTo(self.snp.right)
        }
        
        self.addSubview(scrollView)
        
        self.scrollView.snp.makeConstraints { scrollView in
            scrollView.left.equalTo(self.snp.left)
            scrollView.top.equalTo(self.header.snp.bottom)
            scrollView.right.equalTo(self.snp.right)
            scrollView.bottom.equalTo(self.snp.bottom)
        }
        
        self.scrollView.addSubview(contentView)
        
        self.contentView.snp.makeConstraints { contentView in
            contentView.edges.equalTo(self.scrollView.snp.edges)
            contentView.width.equalTo(self.scrollView.snp.width)
        }
        
        self.contentView.addSubview(termsLabel)
        
        self.termsLabel.snp.makeConstraints {
            $0.edges.equalTo(self.contentView.snp.edges).inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
