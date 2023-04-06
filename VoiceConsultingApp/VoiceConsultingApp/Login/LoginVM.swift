//
//  LoginVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/31.
//

import Foundation
import RxSwift
import RxCocoa

class LoginVM: BaseViewModel {
    
    struct Input {
        let didTapLoginButton: PublishSubject<LoginType> = PublishSubject()
    }
    
    struct Output {
        
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
        self.input.didTapLoginButton
            .bind(onNext: { [weak self] loginType in
                switch loginType {
                case .kakao:
                    print("카카오 로그인")
                case .apple:
                    print("애플 로그인")
                case .google:
                    print("구글 로그인")
                }
            })
            .disposed(by: self.disposeBag)
    }
}
