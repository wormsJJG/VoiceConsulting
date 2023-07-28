//
//  FitWellCounselorCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/06.
//

import UIKit
import Then
import SnapKit
import RxSwift

class FitWellCounselorCell: UICollectionViewCell {
    static let cellID = "fitWellCounselorCell"
    private let disposeBag = DisposeBag()
    //MARK: - View
    lazy var profileImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.thumnail)
        $0.layer.cornerRadius = 30
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
    
    lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [profileImage, counselorName, introduce, categoryBlock]).then {
        
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .leading
    }
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellDesign()
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellDesign() {
        setViewShadow(backView: contentView)
    }
    
    private func constraint() {
        profileImage.snp.makeConstraints { imageView in
            imageView.width.height.equalTo(60)
        }
        
        categoryBlock.snp.makeConstraints { block in
            block.width.equalTo(self.categoryBlock.categoryNameLabel.snp.width).offset(12)
            block.height.equalTo(self.categoryBlock.categoryNameLabel.snp.height).offset(6)
        }
        
        self.contentView.addSubview(allStackView)
        
        self.allStackView.snp.makeConstraints { stackView in
            stackView.center.equalTo(self.contentView.snp.center)
            stackView.left.equalTo(self.contentView.snp.left).offset(16)
            stackView.right.equalTo(self.contentView.snp.right).offset(-16)
        }
    }
    
    func configureCell(in counselor: CounselorInfo) {
        
        self.profileImage.kf.setImage(with: URL(string: counselor.profileImageUrl))
        let randomCategoryId = counselor.categoryList[Int.random(in: 0...counselor.categoryList.count - 1)]
        DispatchQueue.main.async { [weak self] in
            
            self?.counselorName.text = counselor.name
            self?.introduce.text = counselor.introduction
            self?.categoryBlock.categoryName = CategoryManager.shared.convertIdToName(in: randomCategoryId)
        }
    }
}
