//
//  MessageStorage.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/16.
//

import Foundation
import RealmSwift
import RxSwift

class MessageStorage {
    
    static let shared = MessageStorage()
    private let storage: Realm!
    
    private init() {
        
        self.storage = try! Realm()
    }
    
    func fetchMessageListByUid(by uid: String) -> Observable<[RealmMessage]> {
        
        return Observable.create { event in
            
            let result = self.storage.objects(RealmMessageListByUid.self).filter("uid == '\(uid)'")
            if let realmMessageListbyUid = result.first {
                
                event.onNext(realmMessageListbyUid.messageList.map { $0 })
                event.onCompleted()
            } else {
                
                event.onError(RealmError.noDataError)
            }
            return Disposables.create()
        }
    }
    
    func addMessageRoom(by uid: String, message: RealmMessage?) {
        
        do {
            
            try storage.write {
                
                let realmMessageListByUid = RealmMessageListByUid()
                realmMessageListByUid.uid = uid
                if let message {
                    
                    realmMessageListByUid.messageList.append(message)
                }
                
                storage.add(realmMessageListByUid)
            }
        } catch {
            
            print(error.localizedDescription)
        }
    }
    
    func saveMessage(by uid: String, message: RealmMessage) {
        
        let result = storage.objects(RealmMessageListByUid.self).filter("uid = '\(uid)'")
        do {
            
            try storage.write {
                
                result.first?.messageList.append(message)
            }
            
            ChatChannelStorage.shared.editLastMessage(uid: uid, lastMessage: message)
        } catch {
            
            print(error)
        }
    }
    
    func isExitsMessageRoom(by uid: String) -> Bool {
        
        let result = storage.objects(RealmMessageListByUid.self).filter("uid = '\(uid)'")
        
        return false
    }
}
