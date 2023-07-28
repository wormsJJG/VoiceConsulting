//
//  MoreType.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import Foundation

enum HeaderType {
    case live
    case popular
    case fitWell
    case coinManagement
    case alert
    case termsOfUse
    case privacyPolicy
    case heartCounselor
    case review
    case inputCounselrInfo
    case editCounselorInfo
    
    var title: String {
        switch self {
        case .live:
            return "현재 가능한 상담사"
        case .popular:
            return "인기많은 상담사"
        case .fitWell:
            return "나와 잘어울리는 상담사"
        case .coinManagement:
            return "코인관리"
        case .alert:
            return "알림"
        case .termsOfUse:
            return "이용약관"
        case .privacyPolicy:
            return "개인정보 처리방침"
        case .heartCounselor:
            return "찜한 상담사"
        case .review:
            return "리뷰 작성"
        case .inputCounselrInfo:
            return "상담사 회원가입"
        case .editCounselorInfo:
            return "계정 설정"
        }
    }
}
