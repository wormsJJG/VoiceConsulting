//
//  RealmMessageListByUid.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/17.
//

import Foundation
import RealmSwift

class RealmMessageListByUid: Object {
    
    @objc dynamic var uid: String = ""
    let messageList: List<RealmMessage> = List<RealmMessage>()
    
    override class func primaryKey() -> String? {
        
        return "uid"
    }
}
