//
//  SettlementDetail.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/13.
//

import Foundation

struct SettlementDetail: Codable {
    
    var counselorUid: String
    var coinCount: Int
    var price: Int
    var isSettle: Bool
    var createAt: Int
    var accountInfo: String
}
