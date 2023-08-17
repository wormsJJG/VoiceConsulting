//
//  InputUserInfoVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/17.
//

import Foundation
import RxSwift

class InputUserInfoVM: BaseViewModel {
    
    struct Input {
        
        
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
        
    }
}
