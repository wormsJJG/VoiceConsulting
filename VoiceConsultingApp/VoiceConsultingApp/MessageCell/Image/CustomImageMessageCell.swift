//
//  CustomImageMessageCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/21.
//

import UIKit
import Then
import MessageKit
import Kingfisher
import SnapKit

class CustomImageMessageCell: CustomMessageContentCell {
    
    private lazy var imageView: UIImageView = UIImageView().then {
        
        $0.contentMode = .scaleToFill
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        messageContainerView.addSubview(imageView)
        imageView.snp.makeConstraints {
            
            $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
    }
    
    override func configure(with message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView, dataSource: MessagesDataSource, and sizeCalculator: CustomLayoutSizeCalculator) {
        super.configure(with: message, at: indexPath, in: messagesCollectionView, dataSource: dataSource, and: sizeCalculator)
        
        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            
            return 
        }

        switch message.kind {
            
        case .photo(let mediaItem):
            
            imageView.kf.setImage(with: mediaItem.url) { [weak self] result in
                
                switch result {
                case .success(_):
                    
                    print("이미지 로드 성공")
                case .failure(let error):
                    
                    print(error.localizedDescription)
                    self?.imageView.image = mediaItem.placeholderImage
                }
            }
        default:
            break
        }

        displayDelegate.configureMediaMessageImageView(imageView, for: message, at: indexPath, in: messagesCollectionView)
    }
}
