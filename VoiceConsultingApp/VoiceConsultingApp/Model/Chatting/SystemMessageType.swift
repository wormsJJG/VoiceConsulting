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
}
