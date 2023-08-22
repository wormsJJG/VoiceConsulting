//
//  SystemMessageType.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/16.
//

import Foundation

enum SystemMessageType: Int {
    
    case text = 0
    case image = 1
    case requestTranscation = 2
    case transactionCompleted = 3
    case endConsultation = 4
    
    var description: String {
        
        switch self {
            
        case .text:
            
            return ""
        case .image:
            
            return "이미지"
        case .requestTranscation:
            
            return "거래 요청 메세지"
        case .transactionCompleted:
            
            return "거래 완료 메세지"
        case .endConsultation:
            
            return "상담 종료 메세지"
        default:
            
            return ""
        }
    }
}
