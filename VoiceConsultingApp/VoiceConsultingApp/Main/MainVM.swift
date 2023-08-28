//
//  MainVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/26.
//

import Foundation
import RxSwift
import RxCocoa

class MainVM: BaseViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    var sectionTitleList = Observable.of(MainListSection.allCases)
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(),
         output: Output = Output()) {
        
        self.input = input
        self.output = output
    }
}
