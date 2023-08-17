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
    
    func addChatChannel(uid: String, name: String, profileUrlString: String) {
        
        do {
            
            try storage.write {
                
                let chatChannel = ChatChannel()
                chatChannel.uid = uid
                chatChannel.name = name
                chatChannel.profileUrlString = profileUrlString
                chatChannel.lastMessage = RealmMessage(content: "", sender: Sender(senderId: "", displayName: Config.name), sentDate: Date(), messageId: nil)
                
                storage.add(chatChannel)
            }
        } catch {
            
            print(error.localizedDescription)
        }
    }
}
