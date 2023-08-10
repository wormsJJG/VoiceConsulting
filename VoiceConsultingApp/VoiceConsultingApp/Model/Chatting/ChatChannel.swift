//
//  ChatChannel.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/17.
//

import Foundation

struct ChatChannel {
    
    var id: String?
    var name: String
}

extension ChatChannel: Comparable {
    
    static func == (lhs: ChatChannel, rhs: ChatChannel) -> Bool {
        
        return lhs.id == rhs.id
    }
    
    static func < (lhs: ChatChannel, rhs: ChatChannel) -> Bool {
        
        return lhs.name < rhs.name
    }
}
