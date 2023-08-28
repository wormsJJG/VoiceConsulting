//
//  ChattingListClientDelegate.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/21.
//

import Foundation

protocol ChattingListClientDelegate: AnyObject {
    
    func didReceiveMessage(_ message: Message)
}
