//
//  UserData.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/04.
//

import Foundation

struct UserData {
    var profileUrlString: String?
    var name: String
    var type: UseType
    var chatRoomList: [ChatChannel]
}
