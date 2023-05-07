//
//  AgoraPushManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/04.
//

import Foundation
import AgoraChat

class AgoraPushManager: NSObject, AgoraChatManagerDelegate, AgoraChatClientDelegate, AgoraChatMultiDevicesDelegate {
    static let shared = AgoraPushManager()
    
    func initAgoraChatOptions() {
        let options = AgoraChatOptions(appkey: "61936485#1094469")
        options.apnsCertName = "com.team.winconsultingapp"
        
        AgoraChatClient.shared.initializeSDK(with: options)
        AgoraChatClient.shared.login(withUsername: "worms0627", password: "worms1837@")
        print("UserID:::: \(AgoraChatClient.shared.currentUsername)")
    }
    
    func registerForRemoteNotifications(deviceToken: Data) {
        AgoraChatClient.shared.registerForRemoteNotifications(withDeviceToken: deviceToken) { error in
            if let error {
                print("Agora Push Noti Error: \(error.errorDescription!)")
            } else {
                print("\(deviceToken)")
            }
        }
    }
}
