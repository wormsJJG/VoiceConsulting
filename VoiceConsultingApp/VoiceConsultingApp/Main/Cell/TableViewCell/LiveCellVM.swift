//
//  LiveCellVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/09.
//

import Foundation
import RxSwift

class LiveCellVM: BaseViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
    }
}
