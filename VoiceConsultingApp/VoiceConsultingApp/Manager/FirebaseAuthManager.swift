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
    
    func getUserUid() -> String? {
        if isLogin {
            
            return Auth.auth().currentUser!.uid.lowercased()
        }
        
        return nil
    }
    
    func logout() {
        
        let auth = Auth.auth()
        
        do {
            
            try auth.signOut()
        } catch {
            
            print(error.localizedDescription)
        }
    }
    
    func getAccessToken(_ completion: @escaping (Error?, String?) -> Void) {
        
        let currentUser = Auth.auth().currentUser
        
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            
            completion(error, idToken)
        }
    }
}
