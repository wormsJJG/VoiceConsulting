//
//  MessageClient.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/21.
//

import Foundation

class MessageClient {
    
    static let shared = MessageClient()
    var didEnterChatRoomUid: String?
    weak var delegate: MessageReceiveable?
    
    func didEnterChatRoom(uid: String?) {
        
        didEnterChatRoomUid = uid
    }
    
    func didLeaveChatRoom() {
        
        didEnterChatRoomUid = nil
    }
}
