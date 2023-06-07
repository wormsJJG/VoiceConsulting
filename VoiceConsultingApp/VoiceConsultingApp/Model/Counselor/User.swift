//
//  User.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/06.
//

import Foundation

struct User: Codable {
    var isUser: Bool?
    var name: String
    var categoryList: [String]?
    var isOnline: Bool?
    var prfileImageUrl: String?
    var affiliationList: [String]?
    var licenseImages: [String]?
    var phoneNumber: String?
    var heartCount: Int?
    var heartCounselor: [String]?
    var coinCount: Int
    var consultingCount: Int?
    
    init(isUser: Bool? = nil,
         name: String,
         categoryList: [String]? = nil,
         isOnline: Bool? = nil,
         prfileImageUrl: String? = nil,
         affiliationList: [String]? = nil,
         licenseImages: [String]? = nil,
         phoneNumber: String? = nil,
         heartCount: Int? = nil,
         heartCounselor: [String]? = nil,
         coinCount: Int = 0,
         consultingCount: Int? = nil) {
        
        self.isUser = isUser
        self.name = name
        self.categoryList = categoryList
        self.isOnline = isOnline
        self.prfileImageUrl = prfileImageUrl
        self.affiliationList = affiliationList
        self.licenseImages = licenseImages
        self.phoneNumber = phoneNumber
        self.heartCount = heartCount
        self.heartCounselor = heartCounselor
        self.coinCount = coinCount
    }
}
