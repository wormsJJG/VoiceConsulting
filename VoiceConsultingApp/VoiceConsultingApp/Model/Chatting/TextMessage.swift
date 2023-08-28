//
//  TextMessage.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/09.
//

import Foundation

struct TextMessage: Codable {
    
    var message: String
    var typeMessage: Int
    
    enum CodingKeys: CodingKey {
        case message
        case typeMessage
    }
}
