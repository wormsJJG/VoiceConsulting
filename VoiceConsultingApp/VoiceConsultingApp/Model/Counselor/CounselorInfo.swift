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
    var profileImage: String
    var counsultingCount: Int
    var heart: Int
    var isHidden: Bool
    var phoneNumber: String
    var isOnline: Bool
    var reviewPoint: Double
    var shortIntroduction: String
    var longIntroduction: String
    
    init(name: String, category: [String], company: [String], profileImage: String, shortIntroduction: String, longIntroduction: String, phoneNumber: String) {
        self.name = name
        self.category = category
        self.company = company
        self.profileImage = profileImage
        self.shortIntroduction = shortIntroduction
        self.longIntroduction = longIntroduction
        self.counsultingCount = 0
        self.heart = 0
        self.isHidden = true
        self.phoneNumber = phoneNumber
        self.isOnline = false
        self.reviewPoint = 0.0
    }
}
