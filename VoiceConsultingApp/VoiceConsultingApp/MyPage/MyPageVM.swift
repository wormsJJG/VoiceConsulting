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
        var userMenu = Observable.just(MypageUserMenu.allCases)
        var counselorMenu = Observable.just(MypageCounselorMenu.allCases)
    }
    
    var input: Input
    var output: Output
    
    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
    }
}
