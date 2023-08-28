//
//  MessageReciveable.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/21.
//

import Foundation
import AgoraChat

protocol MessageReceiveable: AnyObject {
    
    func didReceiveMessage(message: Message)
}
