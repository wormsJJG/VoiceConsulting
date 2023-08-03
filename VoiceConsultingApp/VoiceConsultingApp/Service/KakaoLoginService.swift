//
//  KakaoLoginService.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/03.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class KakaoLoginService {
    
    static let shared = KakaoLoginService()
    
    func login() {
        
        
    }
    
    func initSDK() {
        
        KakaoSDK.initSDK(appKey: "8b1f0ce91cb113dac7f2372fef9c2037")
    }
    
    func handleOpenUrl(url: URL) -> Bool {
        
        if AuthApi.isKakaoTalkLoginUrl(url) {
            
            return AuthController.handleOpenUrl(url: url)
        }
        
        return false
    }
}
