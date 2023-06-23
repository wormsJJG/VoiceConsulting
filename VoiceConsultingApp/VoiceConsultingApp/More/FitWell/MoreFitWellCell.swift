//
//  MoreFitWellCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import SnapKit
import Then
import Kingfisher

class MoreFitWellCell: UITableViewCell {
    static let cellID = "MoreFitWellCell"
    // MARK: - View
    lazy var thumnailImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.thumnail)
        $0.layer.cornerRadius = 40
        $0.clipsToBounds = true
    }
    
    lazy var counselorName: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.text = "김이름 상담사"
        $0.textColor = ColorSet.mainText
    }
    
    lazy var introduce: UILabel = UILabel().then {
        $0.textColor = ColorSet.subTextColor
        $0.text = "소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 12)
        $0.numberOfLines = 2
    }
    
    lazy var categoryBlock: CategoryBlock = CategoryBlock()
    
    lazy var contentStackView: UIStackView = UIStackView(arrangedSubviews: [counselorName, introduce, categoryBlock]).then {
        
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .leading
    }
    
    lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [thumnailImage, contentStackView]).then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.alignment = .top
    }
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    // MARK: - Constraint
    private func constraint() {
        thumnailImage.snp.makeConstraints { imageView in
            imageView.width.height.equalTo(80)
        }
        
        categoryBlock.snp.makeConstraints { block in
            block.width.equalTo(self.categoryBlock.label.snp.width).offset(12)
            block.height.equalTo(self.categoryBlock.label.snp.height).offset(6)
        }
        
        self.contentView.addSubview(allStackView)
        
        self.allStackView.snp.makeConstraints { sv in
            sv.left.equalTo(self.contentView.snp.left).offset(20)
            sv.top.equalTo(self.contentView.snp.top).offset(20)
            sv.right.equalTo(self.contentView.snp.right).offset(-20)
            sv.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
        }
    }
    // MARK: - configureCell
    func configureCell(in counselorInfo: CounselorInfo) {
        
        thumnailImage.kf.setImage(with: URL(string: counselorInfo.profileImageUrl))
        self.categoryBlock.categoryId = counselorInfo.categoryList[Int.random(in: 0...counselorInfo.categoryList.count - 1)]
        DispatchQueue.main.async { [weak self] in
            
            self?.counselorName.text = counselorInfo.name
            self?.introduce.text = counselorInfo.introduction
        }
    }
}
