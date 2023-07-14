//
//  VoiceRoomVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/14.
//

import UIKit

class VoiceRoomVC: BaseViewController {
    
    // MARK: - Load View
    private let voiceRoomV = VoiceRoomV()
    
    override func loadView() {
        super.loadView()
        
        self.view = voiceRoomV
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
