//
//  AppDelegate.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/22.
//

import UIKit
import FirebaseCore
import UserNotifications
import AgoraChat
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure() // For Firebase
        UNUserNotificationCenter.current().delegate = self // Push Noti Delegate
        AgoraChatClient.shared.add(self, delegateQueue: nil)
        AgoraPushManager.shared.initAgoraChatOptions() //AgoraPush
        CategoryManager.shared.initCategoryData()
        KakaoLoginService.shared.initSDK()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        var handled: Bool
        
        handled = GIDSignIn.sharedInstance.handle(url)
        
        if handled && KakaoLoginService.shared.handleOpenUrl(url: url) {
            return true
        }
        
        return false
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}

// MARK: - Push Noti
extension AppDelegate: UNUserNotificationCenterDelegate, AgoraChatClientDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        AgoraPushManager.shared.registerForRemoteNotifications(deviceToken: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        print("Failed to register: \(error)")
    }
    
    // foreground 상태
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        AgoraChatClient.shared().application(UIApplication.shared, didReceiveRemoteNotification: notification.request.content.userInfo)
        
        completionHandler([.alert, .sound, .badge])
    }
    
    // background
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
//        AgoraChatClient.shared().application(application, didReceiveRemoteNotification: userInfo)
        
        print(userInfo)
        completionHandler(.newData)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print(response.notification.request.content.userInfo)
        completionHandler()
    }
}
