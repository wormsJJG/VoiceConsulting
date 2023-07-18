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
                self?.setCheckDataIsUser(in: isUser)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func setCheckDataIsUser(in isUser: Bool) {
        
        CheckDataManager.shared.setIsUser(in: isUser)
        self.output.isSuccess.onNext(true)
    }
}
