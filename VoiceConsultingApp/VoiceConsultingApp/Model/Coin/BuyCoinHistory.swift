//
//  BuyCoinHistory.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/22.
//

import Foundation

struct BuyCoinHistory: Codable {
    
    var coin: Int
    var createAt: Int
    var discountPercent: Int = 0
    var moneyPayment: Int
    var paymentSourceType: String = "payment_apple"
    var paymentStatus: Int
    var purchaseId: String = ""
    var purchaseItemId: String
    var userId: String
    var updateAt: Int = 0
}
