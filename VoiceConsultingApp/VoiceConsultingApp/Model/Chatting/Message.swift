//
//  Message.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/17.
//

import Foundation
import UIKit
import MessageKit
import AgoraChat

struct Message: MessageType {
    
    var sender: SenderType
    var messageId: String
    var sentDate: Date
    var content: String
    var systemMessageType: SystemMessageType
    var imageUrlString: String
    var kind: MessageKind {
        
        switch systemMessageType {
            
        case .text:
            
            return .text(content)
        case .image:
            
            return .photo(ImageMediaItem(urlString: imageUrlString))
        case .requestTranscation:
            
            return .custom(systemMessageType)
        case .transactionCompleted:
            
            return .custom(systemMessageType)
        case .endConsultation:
            
            return .custom(systemMessageType)
        }
    }
    
    // MARK: - Text
    init(content: String, sender: SenderType, sentDate: Date, messageId: String?) {
        
        if let messageId {
            
            self.messageId = messageId
        } else {
            
            self.messageId = UUID().uuidString
        }
        
        self.sender = sender
        self.sentDate = sentDate
        self.content = content
        self.systemMessageType = .text
        self.imageUrlString = ""
    }
    
    // MARK: - image
    init(imageUrlString: String, sender: SenderType, sentDate: Date, messageId: String?) {
        
        if let messageId {
            
            self.messageId = messageId
        } else {
            
            self.messageId = UUID().uuidString
        }
        
        self.imageUrlString = imageUrlString
        self.sender = sender
        self.sentDate = sentDate
        self.content = "이미지"
        self.systemMessageType = .image
    }
    
    // MARK: - SystemMessage
    init(systemMessageType: SystemMessageType, sender: SenderType, sentDate: Date, messageId: String?) {
        
        if let messageId {
            
            self.messageId = messageId
        } else {
            
            self.messageId = UUID().uuidString
        }
        
        self.systemMessageType = systemMessageType
        self.sender = sender
        self.sentDate = sentDate
        
        switch systemMessageType {
            
        case .requestTranscation:
            
            self.content = "거래 요청 메세지"
        case .transactionCompleted:
            
            self.content = "거래 완료 메세지"
        case .endConsultation:
            
            self.content = "상담 종료 메세지"
        default:
            
            self.content = "요청 에러"
        }
        self.imageUrlString = ""
    }
}
// MARK: - Healper
extension Message {
    
    // Convert Message -> RealmMessage
    func toRealmMessage() -> RealmMessage {
        
        var realmMessage: RealmMessage
        
        if systemMessageType == .text {
            
            realmMessage = RealmMessage(content: content,
                                            sender: sender,
                                            sentDate: sentDate,
                                            messageId: messageId)
            
            return realmMessage
        }
        
        if systemMessageType == .image {
            
            
            
            realmMessage = RealmMessage(imageUrlString: imageUrlString,
                                        sender: sender,
                                        sentDate: sentDate,
                                        messageId: messageId)
                                            
            
            return realmMessage
        }
        
        realmMessage = RealmMessage(systemMessageType: systemMessageType,
                                    sender: sender,
                                    sentDate: sentDate,
                                    messageId: messageId)
        
        return realmMessage
    }
    
    func toAgoraChatMessage(to: String) -> AgoraChatMessage {
        
        var textMessage: TextMessage
        
        if systemMessageType == .text {
            
            textMessage = TextMessage(message: self.content, typeMessage: systemMessageType.rawValue)
        } else if systemMessageType == .image {
            
            textMessage = TextMessage(message: self.imageUrlString, typeMessage: systemMessageType.rawValue)
        } else {
            
            textMessage = TextMessage(message: systemMessageType.description, typeMessage: systemMessageType.rawValue)
        }
        
        let body = String(data: try! JSONEncoder().encode(textMessage), encoding: .utf8)!
        let msg = AgoraChatMessage(conversationId: "\(self.messageId)",
                                   from: self.sender.senderId,
                                   to: to,
                                   body: .text(content: body),
                                   ext: ["em_apns_ext": ["message": self.content,
                                                         "senderName": sender.displayName,
                                                         "typeMessage": self.systemMessageType.rawValue] as [String : Any]])
        
        return msg
    }
}

extension Message: Comparable {
    
  static func == (lhs: Message, rhs: Message) -> Bool {
      
    return lhs.messageId == rhs.messageId
  }

  static func < (lhs: Message, rhs: Message) -> Bool {
      
    return lhs.sentDate < rhs.sentDate
  }
}
