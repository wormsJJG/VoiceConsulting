//
//  Consulting.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/28.
//

import Foundation

typealias ConsultingList = [Consulting]

struct Consulting: Codable {
    
    var callerId: String
    var counselorId: String
    var createAt: Int
    var duration: Int
    var updateAt: Int
    var userId: String
    
    init(userId: String, counselorId: String) {
        
        let nowTimeInterval = Int(Date().timeIntervalSince1970 * 1000)
        self.callerId = userId
        self.counselorId = counselorId
        self.createAt = nowTimeInterval
        self.duration = 0
        self.updateAt = nowTimeInterval
        self.userId = userId
    }
}
