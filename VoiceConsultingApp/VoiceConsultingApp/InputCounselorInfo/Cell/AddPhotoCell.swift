//
//  AddPhotoCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/20.
//

import UIKit
import SnapKit
import Then

class AddPhotoCell: UICollectionViewCell {
    
    static let cellID = "addPhotoCell"
    
    private let cameraIconImageView: UIImageView = UIImageView().then {
        
        $0.image = UIImage(named: AssetImage.cameraIconFull)
    }
    
    private let imageCountLabel: UILabel = UILabel().then {
        
        $0.text = "0/0"
        $0.textColor = ColorSet.date
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textAlignment = .center
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [cameraIconImageView,
                                                                                imageCountLabel]).then {
        
        $0.axis = .vertical
        $0.spacing = 4
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(allStackView)
        
        allStackView.snp.makeConstraints {
            
            $0.center.equalTo(self.contentView.snp.center)
        }
        
        backgroundColor = ColorSet.line
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
