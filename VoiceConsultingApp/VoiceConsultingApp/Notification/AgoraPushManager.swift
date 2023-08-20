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
        
        let options = AgoraChatOptions(appkey: AgoraConst.appKey.rawValue)
        options.apnsCertName = AgoraConst.apnsCertName.rawValue
        
        AgoraChatClient.shared().initializeSDK(with: options)
    }
    
    func registerForRemoteNotifications(deviceToken: Data) {
        AgoraChatClient.shared()
            .registerForRemoteNotifications(withDeviceToken: deviceToken) { error in
            
            if let error {
                
                print("Agora Push Noti Error: \(error.errorDescription!)")
            } else {
                
                print("\(deviceToken)")
            }
        }
    }
    
    func pushManagerSetting() {
        
        AgoraChatClient.shared().pushManager?.setPreferredNotificationLanguage("KR") { error in
            
            if let error {
                
                print(error.errorDescription)
            }
        }
    }
}
