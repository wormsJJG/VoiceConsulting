//
//  CertificateContentCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/07.
//

import UIKit
import Then
import SnapKit

class CertificateContentCell: UICollectionViewCell {
    static let cellID = "certificateContent"
    
    let widthHeight = (UIScreen.main.bounds.width / 3) - 20
    
    let certificateImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.certificateImage)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 10
        
        self.contentView.addSubview(certificateImage)
        
        self.certificateImage.snp.makeConstraints {
            $0.width.height.equalTo(widthHeight)
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
