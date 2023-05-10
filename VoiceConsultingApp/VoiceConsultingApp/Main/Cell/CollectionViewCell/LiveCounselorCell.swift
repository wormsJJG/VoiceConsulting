//
//  LiveCounselorCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/04.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class LiveCounselorCell: UICollectionViewCell {
    static let cellID = "liveCounselorCell"
    // MARK: - View
    private let profileContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
      
        view.layer.cornerRadius = 34
        view.layer.borderWidth = 1
        view.layer.borderColor = ColorSet.mainColor?.cgColor
        view.layer.masksToBounds = true
      
        return view
    }()

    private lazy var profileImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.thumnail)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 30
    }
    
    private lazy var name: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textColor = ColorSet.mainText
        $0.text = "김이름 상담사"
        $0.layer.masksToBounds = true
    }
    
    private lazy var contentStackView: UIStackView = UIStackView(arrangedSubviews: [profileContainerView, name]).then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .center
        $0.distribution = .fillProportionally
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellDesign()
        constraint()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImage.image = nil
        name.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func cellDesign() {
        setViewShadow(backView: contentView)
    }
    
    private func constraint() {
        self.profileContainerView.addSubview(profileImage)
        self.contentView.addSubview(contentStackView)
        self.profileContainerView.snp.makeConstraints { view in
            view.width.height.equalTo(68)
        }
        
        self.profileImage.snp.makeConstraints { image in
            image.width.height.equalTo(60)
            image.center.equalTo(self.profileContainerView.snp.center)
        }
        
        self.contentStackView.snp.makeConstraints { sv in
            sv.center.equalTo(self.contentView.snp.center)
        }
    }
    
    func configureCell(counselor: CounselorInfo) {
        profileImage.kf.setImage(with: URL(string: counselor.profileImage))
        DispatchQueue.main.async {
            self.name.text = counselor.name
        }
    }
}
