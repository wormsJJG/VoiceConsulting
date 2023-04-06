//
//  BannerCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/03.
//

import UIKit
import Then
import SnapKit

class BannerCell: UITableViewCell {
    static let cellID: String = "bannerCell"
    // MARK: - View
    lazy var bannerImage: UIImageView = UIImageView(image: UIImage(named: AssetImage.bannerImage))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func constraint() {
        self.addSubview(bannerImage)
        
        self.bannerImage.snp.makeConstraints { banner in
            banner.edges.equalTo(self)
        }
    }
}
