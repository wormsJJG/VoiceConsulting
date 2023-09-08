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
        let didTapTranscationButton: PublishSubject<Void> = PublishSubject()
        let reportTrigger: PublishSubject<Void> = PublishSubject()
        let didTapHeartButton: PublishSubject<Bool> = PublishSubject()
    }
    
    struct Output {
        
        let reloadTrigger: PublishSubject<Void> = PublishSubject()
        var messageList: [Message] = []
        let isSuccessTranscation: PublishSubject<Bool> = PublishSubject()
        let errorTrigger: PublishSubject<Error> = PublishSubject()
        let isSuccessReport: PublishSubject<Void> = PublishSubject()
        let isSuccessHeart: PublishSubject<Bool> = PublishSubject()
        let isHeartCounselor: PublishSubject<Bool> = PublishSubject()
    }
    
    var input: Input
    var output: Output
    var isCustomInputView: Bool = false
    var channel: ChatChannel?
    var allMessageList: [Message] = []
    
    var sender = Sender(senderId: AgoraManager.shared.currentUser!, displayName: Config.name)
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output()) {
        
        self.input = input
        self.output = output
        inputSubsribe()
    }
    
    private func inputSubsribe() {
        
        input.viewDidLoadTrigger
            .subscribe(onNext: { [weak self] uid in
                
                self?.initUnreadMessage()
                self?.fetchMessageList(by: uid)
                self?.checkCounselorHeart(in: uid)
            })
            .disposed(by: self.disposeBag)
        
        input.saveMessageInRealm
            .map { $0.toRealmMessage() }
            .subscribe(onNext: { [weak self] message in
                
                let channelUid = self!.channel!.uid
                MessageStorage.shared.saveMessage(by: channelUid, message: message)
                self?.output.messageList.append(message.toMessage())
                self?.output.messageList.sort()
                self?.output.reloadTrigger.onNext(())
            })
            .disposed(by: self.disposeBag)
        
        input.didTapTranscationButton
            .subscribe(onNext: { [weak self] _ in
                
                self?.transcation()
            })
            .disposed(by: self.disposeBag)
        
        input.reportTrigger
            .subscribe(onNext: { [weak self] _ in
                
                self?.report()
            })
            .disposed(by: self.disposeBag)
        
        input.didTapHeartButton
            .subscribe(onNext: { [weak self] isHeart in
                
                self?.heartCounselor(isHeart: isHeart)
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
                    
                    self?.output.errorTrigger.onNext(error)
                case .completed:
                    
                    print(#function)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func initUnreadMessage() {
        
        if let channel {
            
            UIApplication.shared.applicationIconBadgeNumber -= channel.unReadMessageCount
            ChatChannelStorage.shared.editUnReadMessageCount(uid: channel.uid, count: 0, isIncrease: false)
        }
    }
    
    // MARK: - Transcation
    private func transcation() {
        
        if Config.coin >= 100 {
            
            UserManager.shared.editCoinCount(in: 100, isIncrease: false, completion: { [weak self] error in
                
                if let error {
                    
                    self?.output.errorTrigger.onNext(error)
                } else {
                    
                    CounselorManager.shared.increaseCoin(by: self!.channel!.uid, coinCount: 100, completion: { [weak self] error in
                        
                        if let error {
                            
                            self?.output.errorTrigger.onNext(error)
                        } else {
                            
                            ConsultingHistoryManager.shared.writeConsultingHistory(userId: self!.sender.senderId, counselorId: self!.channel!.uid, completion: { error in
                                
                                Config.coin -= 100
                                self?.output.isSuccessTranscation.onNext(true)
                            })
                        }
                    })
                }
            })
        } else {
            
            self.output.isSuccessTranscation.onNext(false)
        }
    }
    
    private func report() {
        
        ReportManager.shared.report(reporter: sender.senderId, target: channel!.uid, completion: { [weak self] error in
            
            if let error {
                
                self?.output.errorTrigger.onNext(error)
            } else {
                
                self?.output.isSuccessReport.onNext(())
            }
        })
    }
    
    private func heartCounselor(isHeart: Bool) {
        
        FavouriteManager.shared.addFavouriteCounselor(isHeart: isHeart, counselorUid: channel!.uid)
            .subscribe({ [weak self] event in
                
                let counselorUid = self!.channel!.uid
                switch event {
                    
                case .next(let isHeart):
                    
                    self?.output.isSuccessHeart.onNext(isHeart)
                    if isHeart {
                        
                        CounselorManager.shared.increaseHeart(in: counselorUid)
                    } else {
                        
                        CounselorManager.shared.decreaseHeart(in: counselorUid)
                    }
                case .error(let error):
                    
                    self?.output.errorTrigger.onNext(error)
                case .completed:
                    
                    print(#function)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func checkCounselorHeart(in counselorUid: String) {
        
        FavouriteManager.shared.checkIsFavorite(in: counselorUid)
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let isHeart):
                    
                    self?.output.isHeartCounselor.onNext(isHeart)
                case .error(let error):
                    
                    self?.output.errorTrigger.onNext(error)
                case .completed:
                    
                    print(#function)
                }
            })
            .disposed(by: self.disposeBag)
    }
}
