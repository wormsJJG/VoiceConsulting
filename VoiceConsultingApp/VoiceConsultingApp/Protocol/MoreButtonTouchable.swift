//
//  MorePushable.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/10.
//

import Foundation

enum MoreType {
    
    case live
    case popular
    case fitWell
}

protocol MoreButtonTouchable: AnyObject {
    
    func didTouchMoreButton(_ moreType: MoreType)
}
