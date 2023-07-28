//
//  Favourite.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/29.
//

import Foundation

typealias FavouriteList = [Favourite]

struct Favourite: Codable {
    
    var counselorId: String
    var userId: String
}
