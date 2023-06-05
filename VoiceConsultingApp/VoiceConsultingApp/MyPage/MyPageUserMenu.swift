//
//  MyPageMenu.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import Foundation

enum MypageUserMenu: CaseIterable {
    case heartCounselor
    case consultingHistory
    case termsOfUse
    case privacyPolicy
    case openSourceLib
    case alarmOnOff
    case logOut
    case outOfService
    case callNumber
    
    var title: String {
        switch self {
        case .heartCounselor:
            return "찜한 상담사"
        case .consultingHistory:
            return "상담 내역"
        case .termsOfUse:
            return "이용약관"
        case .privacyPolicy:
            return "개인정보 처리방침"
        case .openSourceLib:
            return "오픈소스 라이브러리"
        case .alarmOnOff:
            return "알림"
        case .logOut:
            return "로그아웃"
        case .outOfService:
            return "회원탈퇴"
        case .callNumber:
            return ""
        }
    }
    
    var row: Int {
        switch self {
        case .heartCounselor:
            return 0
        case .consultingHistory:
            return 1
        case .termsOfUse:
            return 2
        case .privacyPolicy:
            return 3
        case .openSourceLib:
            return 4
        case .alarmOnOff:
            return 5
        case .logOut:
            return 6
        case .outOfService:
            return 7
        case .callNumber:
            return 8
        }
    }
}
