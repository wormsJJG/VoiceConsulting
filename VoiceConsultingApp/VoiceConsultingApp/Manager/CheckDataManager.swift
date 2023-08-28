//
//  CheckDataManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/17.
//

import Foundation

enum CheckDataKey: String {
    
    case isLogin
    case isInputInfo
    case isUser
    case name
    case profileUrl
}

class CheckDataManager {
    
    static let shared = CheckDataManager()
    private let userDefault = UserDefaults.standard
    
    func setIsLogin(in isLogin: Bool) {
        
        userDefault.set(isLogin, forKey: CheckDataKey.isLogin.rawValue)
    }
    
    func setIsUser(in isUser: Bool) {
        
        userDefault.set(isUser, forKey: CheckDataKey.isUser.rawValue)
    }
    
    func setisInputInfo(in isInputInfo: Bool) {
        
        userDefault.set(isInputInfo, forKey: CheckDataKey.isInputInfo.rawValue)
    }
    
    func setName(in name: String) {
        
        userDefault.set(name, forKey: CheckDataKey.name.rawValue)
    }
    
    func setProfileUrl(in profileUrl: String?) {
        
        userDefault.set(profileUrl, forKey: CheckDataKey.profileUrl.rawValue)
    }
    
    func getIsLogin() -> Bool {
        
        return userDefault.bool(forKey: CheckDataKey.isLogin.rawValue)
    }
    
    func getIsUser() -> Bool {
        
        return userDefault.bool(forKey: CheckDataKey.isUser.rawValue)
    }
    
    func getIsInputInfo() -> Bool? {
        
        return userDefault.bool(forKey: CheckDataKey.isInputInfo.rawValue)
    }
    
    func getName() -> String {
        
        return userDefault.string(forKey: CheckDataKey.name.rawValue) ?? "Name"
    }
    
    func getProfileUrl() -> String? {
        
        return userDefault.string(forKey: CheckDataKey.profileUrl.rawValue)
    }
}
