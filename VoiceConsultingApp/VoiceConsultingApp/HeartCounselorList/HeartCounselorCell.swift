//
//  HearCounselorCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/22.
//

import UIKit
import Then
import SnapKit
import Kingfisher
import RxSwift

class HeartCounselorCell: UITableViewCell {
    
    static let cellID = "HeartCounselorCell"
    private let disposeBag = DisposeBag()
    
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
    
    let heartButton: HeartButton = HeartButton().then {
        $0.fill = true
    }
    
    lazy var introduce: UILabel = UILabel().then {
        $0.textColor = ColorSet.subTextColor
        $0.text = "소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개소개"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 12)
        $0.numberOfLines = 2
    }
    
    lazy var categoryBlock: CategoryBlock = CategoryBlock()
    
    lazy var labelAndHeartSV: UIStackView = UIStackView(arrangedSubviews: [counselorName, heartButton]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .equalSpacing
    }
    
    lazy var contentStackView: UIStackView = UIStackView(arrangedSubviews: [labelAndHeartSV, introduce, categoryBlock]).then {
        
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .leading
    }
    
    lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [thumnailImage, contentStackView]).then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.alignment = .top
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.heartButton.didTap = true
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        
        thumnailImage.snp.makeConstraints { imageView in
            imageView.width.height.equalTo(80)
        }
        
        categoryBlock.snp.makeConstraints { block in
            block.width.equalTo(self.categoryBlock.label.snp.width).offset(12)
            block.height.equalTo(self.categoryBlock.label.snp.height).offset(6)
        }
        
        self.contentView.addSubview(allStackView)
        
        self.labelAndHeartSV.snp.makeConstraints {
            $0.left.equalTo(contentStackView.snp.left)
            $0.right.equalTo(contentStackView.snp.right)
        }
        
        self.allStackView.snp.makeConstraints { sv in
            sv.edges.equalToSuperview().inset(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(in counselorUid: String) {
        
        CounselorManager.shared.getCounselor(in: counselorUid)
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let counselor):
                    
                    self?.thumnailImage.kf.setImage(with: URL(string: counselor.info.profileImageUrl))
                    self?.counselorName.text = counselor.info.name
                    self?.introduce.text = counselor.info.introduction
                    self?.categoryBlock.categoryId = counselor.info.categoryList[Int.random(in: 0...counselor.info.categoryList.count - 1)]
                case .error(let error):
                    
                    print(error)
                case .completed:
                    
                    print(#function)
                }
            })
            .disposed(by: self.disposeBag)
    }
}
