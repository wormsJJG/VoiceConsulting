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
    
    func addMessage(by uid: String, message: RealmMessage) {
        
        do {
            
            try storage.write {
                
                let realmMessageListByUid = RealmMessageListByUid()
                realmMessageListByUid.uid = uid
                realmMessageListByUid.messageList.append(message)
                storage.add(realmMessageListByUid)
            }
        } catch {
            
            print(error.localizedDescription)
        }
    }
}
