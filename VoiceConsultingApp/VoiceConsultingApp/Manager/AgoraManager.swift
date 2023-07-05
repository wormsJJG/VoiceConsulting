//
//  ChatManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/27.
//

import Foundation
import AgoraChat
import RxSwift

class AgoraManager {
    static let shared = AgoraManager()
    
        
    func initializeAgoraRTC() {
        let appID = "5257fe4a591b42158279edc716d49c9d"
    }
    
    func register(userUid: String) -> Observable<String> {
        
        return Observable.create { event in
            
            AgoraChatClient.shared
                .register(withUsername: userUid,
                          password: AgoraConst.password.rawValue) { userName, agoraChatError in
                
                    if let agoraChatError {
                        
                        event.onError(agoraChatError as! Error)
                    }
                    
                    event.onNext(userName)
                    event.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func login(userUid: String) -> Observable<Void> {
        
        return Observable.create { event in
            
            AgoraChatClient.shared
                .login(withUsername: userUid, password: AgoraConst.password.rawValue) { nickName, agoraChatError in
                
                    if let agoraChatError {
                        
                        event.onError(agoraChatError as! Error)
                    }
                    
                    event.onNext(())
                    event.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func logout() -> Observable<Void> {
        
        return Observable.create { event in
            
            AgoraChatClient.shared.logout(true) { agoraChatError in
                
                if let agoraChatError {
                    
                    event.onError(agoraChatError as! Error)
                }
                
                event.onNext(())
                event.onCompleted()
            }
            
            return Disposables.create()
        }
    }
}
