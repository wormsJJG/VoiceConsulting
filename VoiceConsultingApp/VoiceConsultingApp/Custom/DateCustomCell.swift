//
//  DateCustomCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/06.
//

import UIKit
import MessageKit

final class DateMessageSizeCalculator: MessageSizeCalculator {
    override func messageContainerSize(for _: MessageType, at _: IndexPath) -> CGSize {
        return CGSize(width: 124, height: 24)
    }
}

final class DateMessagesFlowLayout: MessagesCollectionViewFlowLayout {
    lazy var customMessageSizeCalculator = DateMessageSizeCalculator(layout: self)

        override func cellSizeCalculatorForItem(at indexPath: IndexPath) -> CellSizeCalculator {
            let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
            if case .custom = message.kind {
                return customMessageSizeCalculator
            }
            return super.cellSizeCalculatorForItem(at: indexPath) 
        }
}

final class DateCustomCell: UICollectionViewCell {
    func configure(with message: MessageType, at indexPath: IndexPath, and messagesCollectionView: MessagesCollectionView, date: String) {
        
    }
}
