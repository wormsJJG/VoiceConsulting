//
//  CounselorInfoSection.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/07.
//

import Foundation

enum CounselorInfoSection: CaseIterable {
    case affiliation
    case certificate
    case review
    
    var section: Int {
        switch self {
        case .affiliation:
            return 0
        case .certificate:
            return 1
        case .review:
            return 2
        }
    }
    
    var title: String {
        switch self {
        case .affiliation:
            return "소속기관"
        case .certificate:
            return "자격증 및 활동 인증 서류"
        case .review:
            return "후기"
        }
    }
}
