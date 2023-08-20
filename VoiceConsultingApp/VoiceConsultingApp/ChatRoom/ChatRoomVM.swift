//
//  ChatChannelVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/19.
//

import Foundation
import RxSwift

class ChatRoomVM: BaseViewModel{
    
    struct Input {
        
        let viewDidLoadTrigger: PublishSubject<String> = PublishSubject()
        let saveMessageInRealm: PublishSubject<Message> = PublishSubject()
    }
    
    struct Output {
        
        var reloadTrigger: PublishSubject<Void> = PublishSubject()
        var messageList: [Message] = []
    }
    
    var input: Input
    var output: Output
    var isCustomInputView: Bool = false
    var channel: ChatChannel?
    
    var sender = Sender(senderId: AgoraManager.shared.currentUser!, displayName: Config.name)
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output()) {
        
        self.input = input
        self.output = output
        inputSubsribe()
    }
    
//    deinit {
//            
//        guard let lastMessage = self.output.messageList.last,
//              let channel = self.channel else { return }
//            
//        ChatChannelStorage.shared.editLastMessage(uid: channel.uid, lastMessage: lastMessage)
//    }
    
    private func inputSubsribe() {
        
        input.viewDidLoadTrigger
            .subscribe(onNext: { [weak self] uid in
                
                self?.fetchMessageList(by: uid)
            })
            .disposed(by: self.disposeBag)
        
        input.saveMessageInRealm
            .map { $0.toRealmMessage() }
            .subscribe(onNext: { [weak self] message in
                
                let channelUid = self!.channel!.uid
                MessageStorage.shared.saveMessage(by: channelUid, message: message)
                ChatChannelStorage.shared.editLastMessage(uid: channelUid, lastMessage: message)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func fetchMessageList(by uid: String) {
        
        MessageStorage.shared.fetchMessageListByUid(by: uid)
            .map { $0.map { $0.toMessage() }}
            .subscribe({ [weak self] event in
                    
                switch event {
                    
                case .next(let messageList):
                    
                    self?.output.messageList = messageList
                    self?.output.reloadTrigger.onNext(())
                case .error(let error):
                    
                    print(error)
                case .completed:
                    
                    print(#function)
                }
            })
            .disposed(by: self.disposeBag)
    }
}
