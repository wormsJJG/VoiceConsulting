//
//  AgoraError.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/05.
//

import Foundation

enum AgoraError: Error, LocalizedError {
    
    case failedLogin
    case failedRegister
    case failedSendMessage
    case failedLogout
    
    var errorDescription: String? {
        
        switch self {
            
        case .failedLogin:
            
            return "채팅서버 로그인에 실패했습니다."
        case .failedRegister:
            
            return "채팅서버 회원가입에 실패했습니다."
        case .failedSendMessage:
            
            return "메세지 전송에 실패했습니다."
        case .failedLogout:
            
            return "로그아웃에 실패하였습니다."
        }
    }
}
