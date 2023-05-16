//
//  EndConsultationSizeCalculator.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/16.
//

import Foundation
import MessageKit

class EndConsultationSizeCalculator: CustomLayoutSizeCalculator {
    override func messageContainerSize(for message: MessageType, at indexPath: IndexPath) -> CGSize {
        let size = super.messageContainerSize(for: message, at: indexPath)
        let requestContentSize = requestContentSize(for: message, at: indexPath)
        let selfWidth = requestContentSize.width + cellMessageContentHorizontalPadding
        
        let width = max(selfWidth, size.width)
        let height = size.height + requestContentSize.height
        
        return CGSize(width: width, height: height)
    }

    func requestContentSize(for message: MessageType, at _: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 200)
    }
    
    func requestContentFrame(for message: MessageType, at indexPath: IndexPath) -> CGRect {
        let origin = CGPoint(x: cellMessageContentHorizontalPadding / 2, y: cellMessageContentVerticalPadding / 2)
        let size = requestContentSize(for: message, at: indexPath)
        
        return CGRect(origin: origin, size: size)
    }
}

