//
//  MyPageVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import Foundation
import RxSwift
import RxCocoa

class MypageVM: BaseViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    var menu = Observable.just(MypageMenu.allCases)
    
    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
    }
}
