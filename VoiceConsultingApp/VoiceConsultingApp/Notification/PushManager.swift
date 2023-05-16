//
//  NotificationManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/03.
//

import UserNotifications
import UIKit

class PushManager {
    static let shared = PushManager()
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                print("Permission granted: \(granted)")
                guard granted else {
                    return // 유저가 알림받기를 거부하면
                }
                self.getNotificationSettings()
            }
    }
    
    private func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                print("Notification Settings: \(settings)")
                
                guard settings.authorizationStatus == .authorized else { return }
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}
