//
//  MoreFitWellVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/19.
//

import Foundation
import RxSwift

class MoreFitWellVM: BaseViewModel {
    
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
