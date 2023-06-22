//
//  CounselorDetailVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/19.
//

import Foundation
import RxSwift
import RxCocoa

class CounselorDetailVM: BaseViewModel {
    
    struct Input {
        let getDataTrigger: PublishSubject<String> = PublishSubject()
    }
    
    struct Output {
        let reloadTrigger: PublishSubject<Void> = PublishSubject()
        let section = CounselorInfoSection.allCases
        var counselor: Counselor?
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
        
        input.getDataTrigger
            .subscribe(onNext: { [weak self] counselorUid in
                
                self?.getCounselor(uid: counselorUid)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func getCounselor(uid: String) {
        
        CounselorManager.shared.getCounselor(in: uid)
            .subscribe(onNext: { [weak self] counselor in
                
                self?.output.counselor = counselor
                self?.output.reloadTrigger.onNext(())
            })
            .disposed(by: self.disposeBag)
    }
}
