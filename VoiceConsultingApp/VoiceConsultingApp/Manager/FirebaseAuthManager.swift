//
//  FirebaseAuthManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/04.
//

import Foundation
import FirebaseAuth

class FirebaseAuthManager {
    static let shared = FirebaseAuthManager()
    
    var isLogin: Bool {
        guard Auth.auth().currentUser != nil else {
            return false
        }
        
        return true
    }
}
