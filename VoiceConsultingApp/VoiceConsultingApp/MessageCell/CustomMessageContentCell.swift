//
//  MessageContentCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/11.
//

import UIKit
import MessageKit
import Then

class CustomMessageContentCell: MessageCollectionViewCell {
    // MARK: - Properties
    weak var delegate: MessageCellDelegate?
    // MARK: - View
    var messageContainerView: UIView = UIView().then {
        $0.clipsToBounds = true
        $0.layer.masksToBounds = true
    }
    
    var cellTopLabel: UILabel = UILabel().then {
        $0.text = "2023년 2월 22일 금요일"
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 12)
        $0.textColor = ColorSet.subTextColor2
    }
    
    var cellDateLabel: UILabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .right
        $0.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 12)
        $0.textColor = ColorSet.date
        $0.text = "오후 18:07"
    }
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        cellTopLabel.text = nil
        cellTopLabel.attributedText = nil
        cellDateLabel.text = nil
        cellDateLabel.attributedText = nil
    }
    // MARK: - setupSubviews()
    func setupSubviews() {
        contentView.addSubview(cellTopLabel)
        contentView.addSubview(messageContainerView)
        contentView.addSubview(cellDateLabel)
    }
    
    func configure(with message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView, dataSource: MessagesDataSource, and sizeCalculator: CustomLayoutSizeCalculator) {
        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else { return }
        
        cellTopLabel.frame = sizeCalculator.cellTopLabelFrame(for: message, at: indexPath)
        cellDateLabel.frame = sizeCalculator.cellMessageBottomLabelFrame(for: message, at: indexPath)
        messageContainerView.frame = sizeCalculator.messageContainerFrame(for: message, at: indexPath, fromCurrentSender: dataSource.isFromCurrentSender(message: message))
        cellTopLabel.attributedText = dataSource.cellTopLabelAttributedText(
          for: message,
          at: indexPath)
        cellDateLabel.attributedText = dataSource.messageBottomLabelAttributedText(
          for: message,
          at: indexPath)
        messageContainerView.backgroundColor = displayDelegate.backgroundColor(
          for: message,
          at: indexPath,
          in: messagesCollectionView)
    }
}
