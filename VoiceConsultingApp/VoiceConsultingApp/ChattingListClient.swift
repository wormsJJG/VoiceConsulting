//
//  ChattingListClient.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/21.
//

import Foundation

class ChattingListClient {
    
    static let shared = ChattingListClient()
    weak var delegate: ChattingListClientDelegate?
}
