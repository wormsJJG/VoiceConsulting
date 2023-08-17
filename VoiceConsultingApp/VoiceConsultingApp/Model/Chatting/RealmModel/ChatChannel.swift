//
//  ChatChannel.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/17.
//

import Foundation
import RealmSwift
import Realm

class ChatChannel: Object {
    
    @objc dynamic var uid: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var profileUrlString: String = ""
    @objc dynamic var lastMessage: RealmMessage? = nil
}

extension ChatChannel: Comparable {
    
    static func == (lhs: ChatChannel, rhs: ChatChannel) -> Bool {
        
        return lhs.uid == rhs.uid
    }
    
    static func < (lhs: ChatChannel, rhs: ChatChannel) -> Bool {
        
        return lhs.name < rhs.name
    }
}
