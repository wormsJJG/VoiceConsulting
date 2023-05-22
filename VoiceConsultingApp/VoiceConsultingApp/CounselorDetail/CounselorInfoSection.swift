//
//  CounselorInfoSection.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/07.
//

import Foundation

enum CounselorInfoSection: CaseIterable {
    case category
    case profile
    case tapView
    case affiliation
    case certificate
    case detailIntrodution
    case review
    
    var section: Int {
        switch self {
        case .profile:
            return 0
        case .tapView:
            return 1
        case .category:
            return 2
        case .affiliation:
            return 3
        case .certificate:
            return 4
        case .detailIntrodution:
            return 5
        case .review:
            return 6
        }
    }
    
    var title: String {
        switch self {
        case .category:
            return "카테고리"
        case .affiliation:
            return "소속기관"
        case .certificate:
            return "자격증 및 활동 인증 서류"
        case .review:
            return "후기"
        case .detailIntrodution:
            return "상세소개"
        case .profile:
            return ""
        case .tapView:
            return ""
        }
    }
}
