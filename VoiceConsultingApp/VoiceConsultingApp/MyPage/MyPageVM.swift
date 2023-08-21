//
//  MyPageVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import Foundation
import RxSwift
import RxCocoa

class MypageVM: BaseViewModel {
    struct Input {
        
        let refreshTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        
        let userMenu: PublishSubject<[MypageUserMenu]> = PublishSubject()
        let counselorMenu: PublishSubject<[MypageCounselorMenu]> = PublishSubject()
    }
    
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(),
         output: Output = Output()) {
        
        self.input = input
        self.output = output
        inputSubscribe()
    }
    
    private func inputSubscribe() {
        
        input.refreshTrigger
            .bind(onNext: { [weak self] _ in
                
                if Config.isUser {
                    
                    self?.output.userMenu.onNext(MypageUserMenu.allCases)
                } else {
                    
                    self?.output.counselorMenu.onNext(MypageCounselorMenu.allCases)
                }
            })
            .disposed(by: self.disposeBag)
    }
}
