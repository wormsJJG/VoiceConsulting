//
//  CustomTabBar.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/06.
//

import UIKit
import Then
import SnapKit
import RxCocoa

protocol CustomTabDelegate: AnyObject {
    func didSelectItem(_ item: CustomTabItem)
}

enum CustomTabItem {
    case introduce
    case review
}

class CustomTabBar: UIView {
    weak var delegate: CustomTabDelegate? 
    
    var selectItem: CustomTabItem = .introduce {
        didSet {
            switch selectItem {
            case .introduce:
                introduceLabel.textColor = ColorSet.mainColor
                introduceLine.backgroundColor = ColorSet.mainColor
                reviewLabel.textColor = ColorSet.subTextColor2
                reviewLine.backgroundColor = ColorSet.line
            case .review:
                reviewLabel.textColor = ColorSet.mainColor
                reviewLine.backgroundColor = ColorSet.mainColor
                introduceLabel.textColor = ColorSet.subTextColor2
                introduceLine.backgroundColor = ColorSet.line
            }
        }
    }
    
    let introduceTap: UIView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let introduceLabel: UILabel = UILabel().then {
        $0.text = "소개"
        $0.textColor = ColorSet.subTextColor2
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 14)
    }
    
    let introduceLine: UIView = UIView().then {
        $0.backgroundColor = ColorSet.line
    }
    
    let reviewTap: UIView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let reviewLabel: UILabel = UILabel().then {
        $0.text = "후기"
        $0.textColor = ColorSet.subTextColor2
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 14)
    }
    
    let reviewLine: UIView = UIView().then {
        $0.backgroundColor = ColorSet.line
    }
    
    lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [introduceTap, reviewTap]).then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        constraints()
        self.introduceTap.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapIntroduce)))
        self.reviewTap.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapReview)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapIntroduce() {
        selectItem = .introduce
        delegate?.didSelectItem(.introduce)
    }

    @objc private func didTapReview() {
        selectItem = .review
        delegate?.didSelectItem(.review)
    }
    
    private func constraints() {
        self.introduceTap.addSubview(introduceLabel)
        
        self.introduceLabel.snp.makeConstraints {
            $0.centerX.equalTo(introduceTap.snp.centerX)
            $0.centerY.equalTo(introduceTap.snp.centerY)
        }
        
        self.introduceTap.addSubview(introduceLine)
        
        self.introduceLine.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.left.equalTo(introduceTap.snp.left)
            $0.bottom.equalTo(introduceTap.snp.bottom)
            $0.right.equalTo(introduceTap.snp.right)
        }
        
        self.reviewTap.addSubview(reviewLabel)
        
        self.reviewLabel.snp.makeConstraints {
            $0.centerX.equalTo(reviewTap.snp.centerX)
            $0.centerY.equalTo(reviewTap.snp.centerY)
        }
        
        self.reviewTap.addSubview(reviewLine)
        
        self.reviewLine.snp.makeConstraints {
            $0.height.equalTo(2)
            $0.left.equalTo(reviewTap.snp.left)
            $0.bottom.equalTo(reviewTap.snp.bottom)
            $0.right.equalTo(reviewTap.snp.right)
        }
        
        self.addSubview(allStackView)
        
        self.allStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
