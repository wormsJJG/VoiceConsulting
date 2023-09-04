//
//  MainListSection.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/03.
//

import Foundation

enum MainSectionType: CaseIterable {
    
    case banner //배너
    case liveCounselor //현재 상담 가능한
    case popularCounselor //인기많은
    case fitWellCounselor //잘 어울리는 상담사
    
    var sectionTitle: String {
        
        switch self {
            
        case .banner:
            return "사진이 들어가야함"
        case .liveCounselor:
            return "현재 가능한 상담사"
        case .popularCounselor:
            return "인기많은 상담사"
        case .fitWellCounselor:
            return "나랑 잘 어울리는 상담사"
        }
    }
    
    var row: Int {
        
        switch self {
            
        case .banner:
            return 0
        case .liveCounselor:
            return 1
        case .popularCounselor:
            return 2
        case .fitWellCounselor:
            return 3
        }
    }
}
