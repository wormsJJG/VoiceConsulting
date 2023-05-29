//
//  MessageButtonTouchable.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/26.
//

import Foundation

protocol MessageButtonTouchable: AnyObject {
    func didTapButton(_ systemMessageType: SystemMessageType)
}
