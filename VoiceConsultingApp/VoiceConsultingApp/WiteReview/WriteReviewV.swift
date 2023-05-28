//
//  WriteReviewV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/07.
//

import UIKit
import Then
import SnapKit

class WriteReviewV: UIView {
    let header: PlainHeaderView = PlainHeaderView().then {
        $0.headerType = .review
        $0.isHiddenRefreshButton = true
    }
    
    private lazy var infoLabel: UILabel = UILabel().then {
        $0.text = "상대방과의 통화는 어떠셨나요?\n별점을 매겨주세요!"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 16)
        $0.textAlignment = .center
        $0.numberOfLines = 2
    }
    
    var starScorePicker: StarScorePicker = StarScorePicker().then {
        $0.settings.updateOnTouch = true
        $0.settings.totalStars = 5
        $0.settings.filledImage = UIImage(named: AssetImage.fillStar)
        $0.settings.fillMode = .full
        $0.settings.starSize = 34
        $0.settings.starMargin = 4
        $0.settings.filledColor = ColorSet.mainColor!
        $0.settings.emptyBorderWidth = 0
        $0.settings.emptyColor = ColorSet.line!
        $0.settings.emptyImage = UIImage(named: AssetImage.emptyStar)
        $0.rating = 1.0
    }
    
    private let startCountLabel: UILabel = UILabel().then {
        $0.text = "1.0"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 20)
        $0.numberOfLines = 1
    }
    
    private let textViewInfo: UILabel = UILabel().then {
        $0.text = "리뷰를 작성해주세요!"
        $0.textAlignment = .left
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.numberOfLines = 1
    }
    
    lazy var reviewField: UITextView = UITextView().then {
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        $0.textColor = ColorSet.subTextColor2
        $0.text = "리뷰 작성하기"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorSet.line?.cgColor
    }
    
    private lazy var fieldStackView: UIStackView = UIStackView(arrangedSubviews: [textViewInfo, reviewField]).then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .fill
    }
    
    let completeButton: UIButton = UIButton().then {
        $0.backgroundColor = ColorSet.mainColor
        $0.setTitle("작성 완료", for: .normal)
        $0.titleLabel?.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 10
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
        addattributedText()
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
        
        self.addSubview(infoLabel)
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(self.header.snp.bottom).offset(20)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        self.addSubview(starScorePicker)
        
        starScorePicker.snp.makeConstraints {
            $0.top.equalTo(self.infoLabel.snp.bottom).offset(20)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        self.addSubview(startCountLabel)
        
        startCountLabel.snp.makeConstraints {
            $0.top.equalTo(self.starScorePicker.snp.bottom).offset(10)
            $0.centerX.equalTo(self.snp.centerX)
        }
        
        self.addSubview(fieldStackView)
        
        reviewField.snp.makeConstraints {
            $0.height.equalTo(256)
        }
        
        fieldStackView.snp.makeConstraints {
            $0.left.equalTo(self.snp.left).offset(20)
            $0.top.equalTo(self.startCountLabel.snp.bottom).offset(40)
            $0.right.equalTo(self.snp.right).offset(-20)
        }
        
        self.addSubview(completeButton)
        
        completeButton.snp.makeConstraints {
            $0.height.equalTo(54)
            $0.left.equalTo(self.snp.left).offset(20)
            $0.right.equalTo(self.snp.right).offset(-20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
    
    private func addattributedText() {
        let attributedStr = NSMutableAttributedString(string: infoLabel.text!)
        attributedStr.addAttribute(.foregroundColor, value: ColorSet.mainColor!, range: (infoLabel.text! as NSString).range(of: "통화"))
        self.infoLabel.attributedText = attributedStr

    }
    // MARK: - open func
    func updateStarScoreLabel(score: Double) {
        self.startCountLabel.text = "\(score)"
    }
}
