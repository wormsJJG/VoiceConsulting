//
//  Report.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/09/05.
//

import Foundation

struct Report: Codable {
    
    var reporter: String
    var targetId: String
    var createAt: Int
    
    init(reporter: String, targetId: String) {
        
        self.reporter = reporter
        self.targetId = targetId
        self.createAt = Int(Date().timeIntervalSince1970 * 1000)
    }
}
