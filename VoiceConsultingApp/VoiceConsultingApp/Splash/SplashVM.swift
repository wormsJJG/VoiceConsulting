//
//  SplashVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/23.
//

import Foundation
import RxSwift
import RxCocoa

class SplashVM: BaseViewModel {
    
    struct Input {
        
        let isEnterUser: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        
        let pushMainVCTrigger: PublishSubject<Void> = PublishSubject()
        let isNoLogin: PublishSubject<Void> = PublishSubject()
        let pushSelectUseTypeVCTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        inputSubscribe()
    }
    
    //Subscribing
    private func inputSubscribe() {
        input.isEnterUser
            .subscribe(onNext: { [weak self] _ in
                // 로그인 검사
                if let uid = FirebaseAuthManager.shared.getUserUid() {
                    
                    self?.checkIsUserAndInputData(in: uid)
                } else {
                    
                    self?.output.isNoLogin.onNext(())
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func checkIsUserAndInputData(in uid: String) {
        
        Observable.combineLatest(UserManager.shared.checkField(uid: uid),
                                 CounselorManager.shared.checkField(uid: uid))
        .subscribe({ [weak self] event in
            
            switch event {
                
            case .next((let userLogined, let counselorLogined)):
                
                if userLogined || counselorLogined {
                    
                    if userLogined {
                        
                        self?.saveUserData()
                    } else {
                        
                        self?.saveCounselorData()
                    }
                } else {
                    
                    self?.output.pushSelectUseTypeVCTrigger.onNext(())
                }
            case .error(let error):
                
                print(error.localizedDescription)
            case .completed:
                
                print("completed")
            }
        })
        .disposed(by: self.disposeBag)
    }
    
    private func saveUserData() {
        
        UserManager.shared.getCurrentUserData()
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let user):
                    
                    Config.isUser = true
                    Config.name = user.name
                    Config.profileUrlString = user.profileImageUrl
                    Config.coin = user.coin
                    
                    self?.agoraLogin()
                case .error(let error):
                    
                    print(error.localizedDescription)
                case .completed:
                    
                    print("completed")
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func saveCounselorData() {
        
        if let uid = FirebaseAuthManager.shared.getUserUid() {
            
            CounselorManager.shared.getCounselor(in: uid)
                .subscribe({ [weak self] event in
                    
                    switch event {
                        
                    case .next(let counselor):
                        
                        Config.isUser = false
                        Config.name = counselor.info.name
                        Config.profileUrlString = counselor.info.profileImageUrl
                        Config.coin = counselor.info.coin
                        
                        self?.agoraLogin()
                    case .error(let error):
                        
                        print(error.localizedDescription)
                    case .completed:
                        
                        print("completed")
                    }
                })
                .disposed(by: self.disposeBag)
        }
    }
    
    private func agoraLogin() {
        
        if AgoraManager.shared.currentUser == nil {
            
            if let uid = FirebaseAuthManager.shared.getUserUid() {
                
                AgoraManager.shared.login(userUid: uid)
                    .subscribe({ [weak self] event in
                        
                        switch event {
                            
                        case .next():
                            
                            self?.output.pushMainVCTrigger.onNext(())
                        case .error(let error):
                            
                            print(error.localizedDescription)
                        case .completed:
                            
                            print("completed")
                        }
                    })
                    .disposed(by: self.disposeBag)
            } else {
                
                self.output.isNoLogin.onNext(())
            }
        } else {
            
            self.output.pushMainVCTrigger.onNext(())
        }
    }
}
