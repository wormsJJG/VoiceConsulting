//
//  RealmMessage.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/17.
//

import Foundation
import RealmSwift
import MessageKit

class RealmMessage: Object {
    
    @objc dynamic var senderId: String = ""
    @objc dynamic var displayName: String = ""
    @objc dynamic var messageId: String = ""
    @objc dynamic var sentDate: Date = Date()
    @objc dynamic var content: String = ""
    @objc dynamic var messageType: Int = 0
    @objc dynamic var imageUrlString: String = ""

    // MARK: - Text
    convenience init(content: String, sender: SenderType, sentDate: Date, messageId: String?) {
        self.init()
        
        if let messageId {
            
            self.messageId = messageId
        } else {
            
            self.messageId = UUID().uuidString
        }
        self.senderId = sender.senderId
        self.displayName = sender.displayName
        self.sentDate = sentDate
        self.content = content
        self.messageType = SystemMessageType.text.rawValue
    }
    
    // MARK: - image
    convenience init(imageUrlString: String, sender: SenderType, sentDate: Date, messageId: String?) {
        self.init()
        
        if let messageId {
            
            self.messageId = messageId
        } else {
            
            self.messageId = UUID().uuidString
        }
        self.imageUrlString = imageUrlString
        self.senderId = sender.senderId
        self.displayName = sender.displayName
        self.sentDate = sentDate
        self.content = "이미지"
        self.messageType = SystemMessageType.image.rawValue
    }
    
    // MARK: - SystemMessage
    convenience init(systemMessageType: SystemMessageType, sender: SenderType, sentDate: Date, messageId: String?) {
        self.init()
        
        if let messageId {
            
            self.messageId = messageId
        } else {
            
            self.messageId = UUID().uuidString
        }
        self.messageType = systemMessageType.rawValue
        self.senderId = sender.senderId
        self.displayName = sender.displayName
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
    }
    
    // MARK: - Healper
    
    // Convert RealmMessage -> Message
    func toMessage() -> Message {
        
        let sender = Sender(senderId: senderId, displayName: displayName)
        var message: Message
        
        if messageType == SystemMessageType.text.rawValue {
            
            message = Message(content: content,
                              sender: sender,
                              sentDate: sentDate,
                              messageId: messageId)
            
            return message
        }
        
        if messageType == SystemMessageType.image.rawValue {
            
            message = Message(imageUrlString: imageUrlString,
                              sender: sender,
                              sentDate: sentDate,
                              messageId: messageId)
            
            return message
        }
        
        message = Message(systemMessageType: SystemMessageType(rawValue: messageType)!,
                          sender: sender,
                          sentDate: sentDate,
                          messageId: messageId)
        
        return message
    }
}
