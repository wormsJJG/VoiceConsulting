//
//  RealmError.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/17.
//

import Foundation

enum RealmError: Error, LocalizedError {
    
    case noDataError
    
    var errorDescription: String? {
        
        switch self {
        
        case .noDataError:
            
            return "데이터가 없습니다."
        }
    }
}
