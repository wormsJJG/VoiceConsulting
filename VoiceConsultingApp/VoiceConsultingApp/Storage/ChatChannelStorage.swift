//
//  ChatChannelStorage.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/17.
//

import Foundation
import RealmSwift
import RxSwift

class ChatChannelStorage {
    
    static let shared = ChatChannelStorage()
    private let storage: Realm!
    
    private init() {
        
        self.storage = try! Realm()
    }
    
    func fetchChatChanelList() -> Observable<[ChatChannel]> {
        
        return Observable.create { event in
            
            let result = self.storage.objects(ChatChannel.self)
            
            event.onNext(result.map { $0 })
            event.onCompleted()
            return Disposables.create()
        }
    }
    
    func test() {
        
        let result = self.storage.objects(ChatChannel.self)
        
        print(result.count)
        print(result)
    }
    
    func addChatChannel(uid: String, name: String, profileUrlString: String) -> Observable<ChatChannel> {
        
        return Observable.create { event in
            
            let result = self.storage.objects(ChatChannel.self).filter("uid == '\(uid)'")
            let chatChannel = ChatChannel()
            chatChannel.uid = uid
            chatChannel.name = name
            chatChannel.profileUrlString = profileUrlString
            chatChannel.lastMessage = RealmMessage(content: "", sender: Sender(senderId: "", displayName: Config.name), sentDate: Date(), messageId: nil)
            
            if result.isEmpty {
                
                do {
                    
                    try self.storage.write {
                        
                        self.storage.add(chatChannel)
                        
                        event.onNext(chatChannel)
                        event.onCompleted()
                    }
                } catch {
                    
                    event.onError(error)
                }
            } else {
                
                event.onNext(chatChannel)
                event.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    func editLastMessage(uid: String, lastMessage: RealmMessage) {
        
        let chatChannel = storage.objects(ChatChannel.self).filter("uid = '\(uid)'")
        
        do {
            
            try storage.write {
                
                chatChannel.first?.lastMessage = lastMessage
            }
        } catch {
            
            print(error)
        }
    }
}
