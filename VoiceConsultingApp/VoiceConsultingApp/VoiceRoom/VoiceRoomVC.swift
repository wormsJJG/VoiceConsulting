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
    var rtcKit: AgoraRtcEngineKit!
    
    override func loadView() {
        super.loadView()
        
        self.view = voiceRoomV
    }

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        let config = AgoraRtcEngineConfig()
        config.appId = AgoraConst.appID.rawValue
        
        rtcKit = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
        
        joinChannel()
    }
}

extension VoiceRoomVC: AgoraRtcEngineDelegate {
    
    private func joinChannel() {
        
        let mediaOption = AgoraRtcChannelMediaOptions()
        mediaOption.clientRoleType = .broadcaster
        AgoraTokenService.shared.getAgoraAppToken(completion: { [weak self] error, token in
            
            if let error {
                
                print(error)
            } else {
    
                let result = self?.rtcKit.joinChannel(byToken: token,
                                                      channelId: FirebaseAuthManager.shared.getUserUid()!,
                                                      uid: 0,
                                                      mediaOptions: mediaOption,
                                                      joinSuccess: { (channel, uid, elapsed) in })
                
                print(result)
            }
        })
    }
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        
        print(uid)
    }
    
    func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinChannel channel: String, withUid uid: UInt, elapsed: Int) {
        
        print(channel)
    }
}
