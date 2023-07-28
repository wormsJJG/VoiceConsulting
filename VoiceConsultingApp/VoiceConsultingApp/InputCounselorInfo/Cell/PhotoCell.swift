//
//  PhotoCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/24.
//

import UIKit
import Then
import SnapKit

class PhotoCell: UICollectionViewCell {
    
    static let cellID = "PhotoCell"
    weak var deleteDelegate: DeleteButtonTouchable?
    
    private let imageView: UIImageView = UIImageView()
    private let deleteButton: UIButton = UIButton().then {
        
        $0.setImage(UIImage(named: AssetImage.cancelWhiteIcon), for: .normal)
        $0.backgroundColor = ColorSet.subTextColor2
        $0.alpha = 0.6
        $0.layer.cornerRadius = 11
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addAction()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            
            $0.edges.equalTo(contentView.snp.edges)
        }
        
        contentView.addSubview(deleteButton)
        
        deleteButton.snp.makeConstraints {
            
            $0.width.height.equalTo(22)
            $0.top.equalTo(imageView.snp.top).offset(6)
            $0.right.equalTo(imageView.snp.right).offset(-6)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addAction() {
        
        deleteButton.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
    }
    
    @objc private func didTapDeleteButton() {
        
        deleteDelegate?.didTapDeleteButton(imageView.image)
    }
    
    func configureCell(in image: UIImage?) {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.imageView.image = image
        }
    }
}
