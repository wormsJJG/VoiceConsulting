//
//  ChattingListVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import UIKit
import RxCocoa
import RxSwift

class ChattingListVM: BaseViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    var chatList = Observable.just(["", "", "", "", ""])
    
    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
    }
}
