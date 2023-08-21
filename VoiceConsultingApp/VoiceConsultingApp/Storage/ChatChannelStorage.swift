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
    
    func isExistChannel(by uid: String) -> Bool {
        
        let result = self.storage.objects(ChatChannel.self).filter("uid == '\(uid)'")
        
        return !result.isEmpty
    }
    
    func addChatChannel(chatChannel: ChatChannel) {
        
        let messageRoom = RealmMessageListByUid()
        messageRoom.uid = chatChannel.uid
        if let lastMessage = chatChannel.lastMessage {
            
            messageRoom.messageList.append(chatChannel.lastMessage!)
            
        } else {
            
            let sender = Sender(senderId: chatChannel.uid, displayName: chatChannel.name)
            chatChannel.lastMessage = RealmMessage(content: "", sender: sender, sentDate: Date(), messageId: nil)
        }
        
        
        do {
            
            try self.storage.write {
                        
                self.storage.add(chatChannel)
                self.storage.add(messageRoom)
            }
        } catch {
                    
            print(error.localizedDescription)
        }
    }
    
    func addChatChannelCompletion(chatChannel: ChatChannel, completion: @escaping ((Error?) -> Void)) {
        
        let messageRoom = RealmMessageListByUid()
        messageRoom.uid = chatChannel.uid
        if let lastMessage = chatChannel.lastMessage {
            
            messageRoom.messageList.append(chatChannel.lastMessage!)
            
        } else {
            
            let sender = Sender(senderId: chatChannel.uid, displayName: chatChannel.name)
            chatChannel.lastMessage = RealmMessage(content: "", sender: sender, sentDate: Date(), messageId: nil)
        }
        
        
        do {
            
            try self.storage.write {
                        
                self.storage.add(chatChannel)
                self.storage.add(messageRoom)
                completion(nil)
            }
        } catch {
                    
            completion(error)
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
    
    func editUnReadMessageCount(uid: String, count: Int, isIncrease: Bool) {
        
        let chatChannel = storage.objects(ChatChannel.self).filter("uid = '\(uid)'")
        
        do {
            
            try storage.write {
                
                if isIncrease {
                    
                    chatChannel.first?.unReadMessageCount += count
                } else {
                    
                    chatChannel.first?.unReadMessageCount = count
                }
            }
        } catch {
            
            print(error)
        }
    }
}
