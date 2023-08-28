//
//  CustomImageLayoutSizeCalculator.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/22.
//

import UIKit
import MessageKit

class CustomImageLayoutSizeCalculator: CustomLayoutSizeCalculator {
    
    private let defaultSize = CGSize(width: 240, height: 240)
    
    override func messageContainerSize(for message: MessageType, at indexPath: IndexPath) -> CGSize {
        
        return defaultSize
    }
}
