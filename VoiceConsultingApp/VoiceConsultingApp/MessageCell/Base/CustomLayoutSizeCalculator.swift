//
//  CustomLayoutSizeCalculator.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/11.
//

import UIKit
import MessageKit

class CustomLayoutSizeCalculator: CellSizeCalculator {
  // MARK: Lifecycle

  init(layout: MessagesCollectionViewFlowLayout? = nil) {
    super.init()

    self.layout = layout
  }

  // MARK: Internal

    var cellTopLabelVerticalPadding: CGFloat = 44
    var cellTopLabelHorizontalPadding: CGFloat = 22
    var cellMessageContainerHorizontalPadding: CGFloat = 40
    var cellMessageContainerExtraSpacing: CGFloat = 50 // 최소 여백
    var cellMessageContentVerticalPadding: CGFloat = 20
    var cellMessageContentHorizontalPadding: CGFloat = 20
    var cellDateLabelHorizontalPadding: CGFloat = 24
    var cellDateLabelBottomPadding: CGFloat = 8
    var cellMessageContainerDateSpacing: CGFloat = 6
    var cellProfileHorizontialSpacing: CGFloat = 20 //왼쪽 벽과 프로필 간격
    var profileMessageContainerSpacing: CGFloat = 10 //프로필과 메세지 컨테이너 간격

  var messagesLayout: MessagesCollectionViewFlowLayout {
    layout as! MessagesCollectionViewFlowLayout
  }

  var messageContainerMaxWidth: CGFloat {
    messagesLayout.itemWidth -
      cellMessageContainerHorizontalPadding -
      cellMessageContainerExtraSpacing
  }

  var messagesDataSource: MessagesDataSource {
    self.messagesLayout.messagesDataSource
  }

  override func sizeForItem(at indexPath: IndexPath) -> CGSize {
    let dataSource = messagesDataSource
    let message = dataSource.messageForItem(
      at: indexPath,
      in: messagesLayout.messagesCollectionView)
    let itemHeight = cellContentHeight(
      for: message,
      at: indexPath)
    return CGSize(
      width: messagesLayout.itemWidth,
      height: itemHeight)
  }

  func cellContentHeight(
    for message: MessageType,
    at indexPath: IndexPath)
    -> CGFloat
  {
    cellTopLabelSize(
      for: message,
      at: indexPath).height +
      messageContainerSize(
        for: message,
        at: indexPath).height
  }
    // MARK: - ProfileView
    
    func profileViewSize(for message: MessageType, at indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 40)
    }
    
    func profileViewFrame(for message: MessageType, at indexPath: IndexPath) -> CGRect {
        let y: CGFloat
        let cellTopLabelSize = cellTopLabelSize(for: message, at: indexPath)
        if cellTopLabelSize == .zero {
            y = 0
        } else {
            y = cellTopLabelSize.height
        }
        let origin = CGPoint(x: cellProfileHorizontialSpacing, y: y)
        let size = profileViewSize(for: message, at: indexPath)
        return CGRect(origin: origin, size: size)
    }

  // MARK: - Top cell Label

  func cellTopLabelSize(
    for message: MessageType,
    at indexPath: IndexPath)
    -> CGSize
  {
    guard
      let attributedText = messagesDataSource.cellTopLabelAttributedText(
        for: message,
        at: indexPath) else
    {
      return .zero
    }

    let maxWidth = messagesLayout.itemWidth - cellTopLabelHorizontalPadding
    let size = attributedText.size(consideringWidth: maxWidth)
    let height = size.height + cellTopLabelVerticalPadding

    return CGSize(
      width: maxWidth,
      height: height)
  }

  func cellTopLabelFrame(
    for message: MessageType,
    at indexPath: IndexPath)
    -> CGRect
  {
    let size = cellTopLabelSize(
      for: message,
      at: indexPath)
    guard size != .zero else {
      return .zero
    }

    let origin = CGPoint(
      x: cellTopLabelHorizontalPadding / 2,
      y: 0)

    return CGRect(
      origin: origin,
      size: size)
  }

  func cellDateLabelSize(
    for message: MessageType,
    at indexPath: IndexPath)
    -> CGSize
  {
    guard
      let attributedText = messagesDataSource.messageBottomLabelAttributedText(
        for: message,
        at: indexPath) else
    {
      return .zero
    }
    let maxWidth = messageContainerMaxWidth - cellMessageContainerDateSpacing

    return attributedText.size(consideringWidth: maxWidth)
  }

  func cellDateLabelFrame(
    for message: MessageType,
    at indexPath: IndexPath,
    fromCurrentSender: Bool)
    -> CGRect
  {
      let profileWidth = profileViewSize(for: message, at: indexPath).width
      let messageContainerSize = messageContainerSize(
      for: message,
      at: indexPath)
      let labelSize = cellDateLabelSize(
      for: message,
      at: indexPath)
      let messageContainerX = messagesLayout.itemWidth - (messageContainerSize.width + 20) //MessageContainer의 X좌표
      let x: CGFloat
      let y: CGFloat
      let cellTopLabelSize = cellTopLabelSize(for: message, at: indexPath)

      if fromCurrentSender {
          x = (messageContainerX - labelSize.width) - cellMessageContainerDateSpacing //DateLabel의 X좌표
      } else {
          x = cellProfileHorizontialSpacing + profileWidth + profileMessageContainerSpacing + messageContainerSize.width + 6
      }
      
      if cellTopLabelSize == .zero {
          y = messageContainerSize.height - labelSize.height
      } else {
          y = messageContainerSize.height - labelSize.height + cellTopLabelSize.height
      }
      
      let origin = CGPoint(
      x: x,
      y: y)

      return CGRect(
      origin: origin,
      size: labelSize)
  }

  // MARK: - MessageContainer

  func messageContainerSize(
    for message: MessageType,
    at indexPath: IndexPath)
    -> CGSize
  {
    let width = cellMessageContentHorizontalPadding
    let height = cellMessageContentVerticalPadding

    return CGSize(
      width: width,
      height: height)
  }

  func messageContainerFrame(
    for message: MessageType,
    at indexPath: IndexPath,
    fromCurrentSender: Bool)
    -> CGRect
  {
      let profileWidth = profileViewSize(for: message, at: indexPath).width
    let y = cellTopLabelSize(
      for: message,
      at: indexPath).height
    let size = messageContainerSize(
      for: message,
      at: indexPath)
    let origin: CGPoint
    if fromCurrentSender {
      let x = messagesLayout.itemWidth -
        size.width -
        (cellMessageContainerHorizontalPadding / 2)
      origin = CGPoint(x: x, y: y)
    } else {
      origin = CGPoint(
        x: cellProfileHorizontialSpacing + profileWidth + profileMessageContainerSpacing,
        y: y)
    }

    return CGRect(
      origin: origin,
      size: size)
  }
}

