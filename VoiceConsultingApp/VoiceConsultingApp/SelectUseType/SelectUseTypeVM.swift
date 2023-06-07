//
//  SelectUseTypeVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/27.
//

import Foundation
import RxSwift
import RxCocoa

enum UseType {
    case user
    case counselor
}

class SelectUseTypeVM: BaseViewModel {
    struct Input {
        let selectUseType: PublishSubject<UseType> = PublishSubject()
        let didTapNextButton: PublishSubject<Bool> = PublishSubject()
    }
    
    struct Output {
        let isNextButtonEnable: BehaviorRelay<Bool> = BehaviorRelay(value: false)
        let isSuccess: PublishSubject<Bool> = PublishSubject()
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
    // MARK: - Subscribe
    private func inputSubscribe() {
        input.selectUseType
            .subscribe(onNext: { [weak self] _ in
                self?.output.isNextButtonEnable.accept(true)
            })
            .disposed(by: self.disposeBag)
        
        input.didTapNextButton
            .subscribe(onNext: { [weak self] isUser in
                self?.addFieldIsuser(isUser: isUser)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func addFieldIsuser(isUser: Bool) {
        
        UserManager.shared.addUserType(isUser: isUser)
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next():
                    self?.output.isSuccess.onNext(true)
                case .error(let error):
                    print(error.localizedDescription)
                    self?.output.isSuccess.onNext(false)
                case .completed:
                    print("completed")
                }
            })
            .disposed(by: self.disposeBag)
    }
}
