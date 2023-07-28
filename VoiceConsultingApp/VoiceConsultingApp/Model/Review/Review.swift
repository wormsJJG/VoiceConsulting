//
//  Review.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/26.
//

import Foundation

typealias ReviewList = [Review]

struct Review: Codable {
    
    var content: String
    var counselorId: String
    var score: Double
    var userId: String
    var createAt: Int
}
