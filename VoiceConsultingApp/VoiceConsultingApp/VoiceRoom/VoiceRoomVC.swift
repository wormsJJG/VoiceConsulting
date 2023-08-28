//
//  VoiceRoomVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/14.
//

import UIKit
import AgoraRtcKit

class VoiceRoomVC: BaseViewController {
    
    // MARK: - Load View
    private let voiceRoomV = VoiceRoomV()
    let rtcKit: AgoraRtcEngineKit = AgoraRtcEngineKit()
    
    override func loadView() {
        super.loadView()
        
        self.view = voiceRoomV
    }

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension VoiceRoomVC {
    
    private func test() {
        
    }
}
