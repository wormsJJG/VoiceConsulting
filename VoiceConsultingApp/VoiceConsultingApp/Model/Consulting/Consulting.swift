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
}
