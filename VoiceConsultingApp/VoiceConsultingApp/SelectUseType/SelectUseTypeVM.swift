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
    
    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
    }
}
