//
//  AuthError.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/04.
//

import Foundation

enum AuthError: Error {
    case optionalAuthResult
    case noCurrentUser
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .optionalAuthResult:
            return "로그인 요청에 값이 없습니다."
        case .noCurrentUser:
            return "로그인 기록이 없습니다."
        }
    }
}
