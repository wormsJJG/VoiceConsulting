//
//  CustomTextMessageCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/12.
//

import MessageKit
import UIKit

class CustomTextMessageCell: CustomMessageContentCell {
  /// The label used to display the message's text.
  var messageLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
      label.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 14)

    return label
  }()

  override func prepareForReuse() {
    super.prepareForReuse()

    messageLabel.attributedText = nil
    messageLabel.text = nil
      
  }

  override func setupSubviews() {
    super.setupSubviews()

    messageContainerView.addSubview(messageLabel)
  }

  override func configure(
    with message: MessageType,
    at indexPath: IndexPath,
    in messagesCollectionView: MessagesCollectionView,
    dataSource: MessagesDataSource,
    and sizeCalculator: CustomLayoutSizeCalculator)
  {
    super.configure(
      with: message,
      at: indexPath,
      in: messagesCollectionView,
      dataSource: dataSource,
      and: sizeCalculator)

    guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
      return
    }

    let calculator = sizeCalculator as? CustomTextLayoutSizeCalculator
    messageLabel.frame = calculator?.messageLabelFrame(
      for: message,
      at: indexPath) ?? .zero

    let textMessageKind = message.kind
    switch textMessageKind {
    case .text(let text), .emoji(let text):
      let textColor = displayDelegate.textColor(for: message, at: indexPath, in: messagesCollectionView)
      messageLabel.text = text
      messageLabel.textColor = textColor
    case .attributedText(let text):
      messageLabel.attributedText = text
    default:
      break
    }
  }
}

