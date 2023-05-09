//
//  Counselor.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/08.
//

import Foundation

struct CounselorInfo: Codable {
    var name: String
    var category: [String]
    var company: [String]
    var progileImage: String
    var introduction: String
    var counsultingCount: Int
    var heart: Int
    var isHidden: Bool
    var phoneNumber: String
    var isOnline: Bool
    var coverImages: [String]
    
    init(name: String, category: [String], company: [String], progileImage: String, introduction: String, phoneNumber: String, coverImages: [String]) {
        self.name = name
        self.category = category
        self.company = company
        self.progileImage = progileImage
        self.introduction = introduction
        self.counsultingCount = 0
        self.heart = 0
        self.isHidden = true
        self.phoneNumber = phoneNumber
        self.isOnline = false
        self.coverImages = coverImages
    }
}
