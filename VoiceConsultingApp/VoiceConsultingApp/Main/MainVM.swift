//
//  MainVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/26.
//

import Foundation

class MainVM: BaseViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    
    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
    }
}