//
//  Category.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/31.
//

import Foundation

struct Category {
    var title: String
    var content: String
}

class CategoryManager {
    static let shared = CategoryManager()
    let data: [Category] = [Category(title: "성인상담", content: "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용"),
                            Category(title: "아동상담", content: "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용"),
                            Category(title: "청소년 상담", content: "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용"),
                            Category(title: "부부 상담", content: "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용"),
                            Category(title: "가족 상담", content: "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용")]
}
