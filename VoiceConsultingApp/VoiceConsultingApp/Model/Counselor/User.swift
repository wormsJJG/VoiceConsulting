//
//  User.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/06.
//

import Foundation

struct User: Codable {
    
    var name: String
    var categoryList: [String]
    var phoneNumber: String?
    var coin: Int
    var fcmToken: String?
    var platform: String
    var profileImageUrl: String?
    
    init(name: String,
         categoryList: [String],
         phoneNumber: String? = nil,
         coin: Int = 0,
         fcmToken: String? = nil,
         platform: String = "apple",
         profileImageUrl: String?) {
        
        self.name = name
        self.categoryList = categoryList
        self.phoneNumber = phoneNumber
        self.coin = coin
        self.fcmToken = fcmToken
        self.platform = platform
        self.profileImageUrl = profileImageUrl
    }
}
