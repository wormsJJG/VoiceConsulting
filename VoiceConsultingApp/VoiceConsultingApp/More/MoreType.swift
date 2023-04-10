//
//  MoreType.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import Foundation

enum MoreType {
    case live
    case popular
    case fitWell
    
    var title: String {
        switch self {
        case .live:
            return "현재 가능한 상담사"
        case .popular:
            return "인기많은 상담사"
        case .fitWell:
            return "나와 잘어울리는 상담사"
        }
    }
}
