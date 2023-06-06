//
//  MypageCounselorMenu.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/05.
//

import Foundation

enum MypageCounselorMenu: CaseIterable {
    case showProfile
    case revenueManagement
    case termsOfUse
    case privacyPolicy
    case openSourceLib
    case alarmOnOff
    case isOnlineOnOff
    case logOut
    case outOfService
    case callNumber
    
    var title: String {
        
        switch self {
        
        case .showProfile:
            return "프로필 보기"
        case .revenueManagement:
            return "수익 관리"
        case .termsOfUse:
            return "이용약관"
        case .privacyPolicy:
            return "개인정보 처리방침"
        case .openSourceLib:
            return "오픈소스 라이브러리"
        case .alarmOnOff:
            return "알림"
        case .isOnlineOnOff:
            return "즉시 상담 가능"
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
            
        case .showProfile:
            return 0
        case .revenueManagement:
            return 1
        case .termsOfUse:
            return 2
        case .privacyPolicy:
            return 3
        case .openSourceLib:
            return 4
        case .alarmOnOff:
            return 5
        case .isOnlineOnOff:
            return 6
        case .logOut:
            return 7
        case .outOfService:
            return 8
        case .callNumber:
            return 9
        }
    }

}
