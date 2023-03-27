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
    }
    
    struct Output {
        let isNextButtonEnable: BehaviorRelay<Bool> = BehaviorRelay(value: false)
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
                print("true")
            })
            .disposed(by: self.disposeBag)
    }
}
