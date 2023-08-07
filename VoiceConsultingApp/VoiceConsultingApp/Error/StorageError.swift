//
//  StorageError.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/07.
//

import Foundation

enum StorageError: Error, LocalizedError {
    
    case nilImage
    case nilUrl
    
    var errorDescription: String? {
        
        switch self {
            
        case .nilImage:
            return "이미지가 없습니다."
        case .nilUrl:
            return "파일 URL을 받아오지 못했습니다."
        }
    }
}
