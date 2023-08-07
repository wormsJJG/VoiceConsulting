//
//  Counselor.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/08.
//

import Foundation

struct CounselorInfo: Codable {
    var name: String
    var categoryList: [String]
    var profileImageUrl: String
    var consultingCount: Int
    var heartCount: Int
    var isHidden: Bool
    var phoneNumber: String?
    var isOnline: Bool
    var coin: Int
    var platform: String
    var affiliationList: [String]
    var licenseImages: [String]
    var introduction: String
    var reviewPoint: Double?
    var fcmToken: String?
    
    init(name: String, categoryList: [String], affiliationList: [String], licenseImages: [String], profileImageUrl: String, introduction: String, phoneNumber: String?) {
        self.name = name
        self.categoryList = categoryList
        self.profileImageUrl = profileImageUrl
        self.introduction = introduction
        self.affiliationList = affiliationList
        self.licenseImages = licenseImages
        self.phoneNumber = phoneNumber
        self.heartCount = 0
        self.coin = 0
        self.platform = "apple"
        self.isHidden = true
        self.consultingCount = 0
        self.isOnline = false
    }
}
