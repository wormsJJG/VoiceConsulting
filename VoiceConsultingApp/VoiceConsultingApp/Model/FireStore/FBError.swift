//
//  FBError.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/09.
//

import Foundation

enum FBError: Error, LocalizedError {
    case nilQuerySnapshot
    
    var errorDescription: String {
        switch self {
        case .nilQuerySnapshot:
            return "쿼리 스냅샷이 없습니다."
        }
    }
}
