//
//  AgoraTokenService.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/14.
//

import Foundation
import FirebaseFunctions

class AgoraTokenService {
    
    static let shared = AgoraTokenService()
    lazy var functions = Functions.functions(region: "asia-northeast3")
    
    func getAgoraAppToken(completion: @escaping (Error?, String?) -> Void) {
        
        FirebaseAuthManager.shared.getAccessToken({ error, accessToken in
            
            if let error {
                
                completion(error, nil)
            } else {
                
                self.functions.httpsCallable("makeAgoraChatToken").call(["accessToken": accessToken]) { result, error in
                
                    completion(error, result?.data as? String)
                }
            }
        })
    }
}
