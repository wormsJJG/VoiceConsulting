//
//  ChatManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/27.
//

import Foundation
import AgoraChat
import RxSwift
import Alamofire

class AgoraManager {
    
    static let shared = AgoraManager()
    private let registerUrl = "https://a61.chat.agora.io/61936485/1094469/users"
    private let contentType = "application/json"
    private var session: URLSession?
    
    var currentUser: String? {
        
        return AgoraChatClient.shared().currentUsername
    }
        
    func initializeAgoraRTC() {
        
        let appID = "5257fe4a591b42158279edc716d49c9d"
    }
    
    func register(userUid: String) -> Observable<Data> {

        return Observable.create { event in

            let lowercaseUid = userUid.lowercased()

            AgoraTokenService.shared.getAgoraAppToken(completion: { error, token in
                
                if let error {
                    
                    event.onError(error)
                }
                
                if let token {
                    
                    AF.request(self.registerUrl,
                               method: .post,
                               parameters: ["username": lowercaseUid,
                                            "password": AgoraConst.password.rawValue,
                                            "nickname": lowercaseUid],
                               encoding: JSONEncoding(options: []),
                               headers: ["Content-Type": self.contentType,
                                                     "Authorization": "Bearer \(token)"])
                    .responseData(completionHandler: { response in

                        switch response.result {

                        case .success(let res):
        
                            event.onNext(res)
                            event.onCompleted()
                        case .failure(let error):
                            
                            event.onError(error)
                        }
                    })
                }
            })

            return Disposables.create()
        }
    }
    
    func login(userUid: String) -> Observable<Void> {
        
        return Observable.create { event in
            
            AgoraChatClient.shared()
                .login(withUsername: userUid, password: AgoraConst.password.rawValue) { nickName, agoraChatError in
                
                    if agoraChatError != nil {
                        
                        event.onError(AgoraError.failedLogin)
                    }
                    
                    event.onNext(())
                    event.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func logout() -> Observable<Void> {
        
        return Observable.create { event in
            
            AgoraChatClient.shared().logout(true) { agoraChatError in
                
                if let agoraChatError {
                    
                    event.onError(AgoraError.failedLogout)
                }
                
                event.onNext(())
                event.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func exitAgoraAccount() {
        
        AgoraChatClient.shared
    }
    
    func setPushTemplate() {
        
        AgoraChatClient.shared().pushManager?.setPushTemplate("iOSApnsPush")
    }
}
