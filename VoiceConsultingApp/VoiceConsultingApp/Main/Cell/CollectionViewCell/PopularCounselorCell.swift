//
//  PopularCounselorCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/06.
//

import UIKit
import Then
import SnapKit

class PopularCounselorCell: UICollectionViewCell {
    static let cellID = "popularCounselorCell"
    // MARK: - View
    private lazy var profileImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.thumnail)
        $0.layer.cornerRadius = 30
        $0.clipsToBounds = true
    }
    
    private lazy var badge: CounselorBadge = CounselorBadge()
    
    private lazy var counselorName: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.text = "김이름 상담사"
        $0.textColor = ColorSet.mainText
    }
    
    private lazy var introduce: UILabel = UILabel().then {
        $0.textColor = ColorSet.subTextColor
        $0.text = "소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 12)
        $0.numberOfLines = 2
    }
    
    private lazy var heartImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.heart_Fill)
    }
    
    private lazy var heartCountLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.text = "40"
        $0.textColor = ColorSet.mainColor
    }
    
    private lazy var heartStackView: UIStackView = UIStackView(arrangedSubviews: [heartImage, heartCountLabel]).then {
        $0.axis = .horizontal
        $0.spacing = 4
        $0.distribution = .fill
        $0.alignment = .center
    }
    
    private lazy var consultationCount: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 12)
        $0.text = "상담 400회"
        $0.textColor = ColorSet.subTextColor
    }
    
    private lazy var footerStackView: UIStackView = UIStackView(arrangedSubviews: [heartStackView, consultationCount]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [profileImage, badge, counselorName, introduce, footerStackView]).then {
        
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .center

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellDesign()
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellDesign() {
        textColorChange()
        setViewShadow(backView: contentView)
    }
    
    private func constraint() {
        profileImage.snp.makeConstraints { imageView in
            imageView.width.height.equalTo(60)
        }
        
        badge.snp.makeConstraints { badge in
            badge.width.equalTo(self.badge.label.snp.width).offset(12)
            badge.height.equalTo(23)
        }
        
        heartImage.snp.makeConstraints { star in
            star.width.height.equalTo(14)
        }
        
        self.contentView.addSubview(allStackView)
        
        self.allStackView.snp.makeConstraints { stackView in
            stackView.center.equalTo(self.contentView.snp.center)
            stackView.left.equalTo(self.contentView.snp.left).offset(16)
            stackView.right.equalTo(self.contentView.snp.right).offset(-16)
        }
        
        self.footerStackView.snp.makeConstraints { sv in
            sv.left.equalTo(self.allStackView.snp.left)
            sv.right.equalTo(self.allStackView.snp.right)
        }
    }
    
    private func textColorChange() {
        guard let text = self.consultationCount.text else { return }
        let attributeString = NSMutableAttributedString(string: text)

        attributeString.addAttribute(.foregroundColor, value: ColorSet.mainColor!, range: (text as NSString).range(of: text.filter { $0.isNumber }))

        // myLabel에 방금 만든 속성을 적용합니다.
        self.consultationCount.attributedText = attributeString
    }
    
    func configureCell(in counselor: CounselorInfo) {
        self.profileImage.kf.setImage(with: URL(string: counselor.profileImageUrl))
        DispatchQueue.main.async { [weak self] in
            self?.counselorName.text = counselor.name
            self?.introduce.text = counselor.introduction
            self?.heartCountLabel.text = "\(counselor.heartCount)"
            self?.consultationCount.text = "상담 \(counselor.consultingCount)회"
            self?.textColorChange()
        }
    }
}
