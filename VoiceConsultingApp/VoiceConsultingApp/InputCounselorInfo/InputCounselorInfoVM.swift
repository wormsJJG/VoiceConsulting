//
//  InputCounselorInfoVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/20.
//

import Foundation
import RxSwift

class InputCounselorInfoVM: BaseViewModel {
    
    struct Input {
        
        let didTapAddAffiliationField: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        
        var profileImageList: [UIImage?] = [nil]
        let addAffiliationFieldEvent: PublishSubject<Int> = PublishSubject()
    }
    
    var input: Input
    var output: Output
    var isSelectProfile: Bool = true
    private var affiliationFieldCount: Int = 1
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(),
         output: Output = Output()) {
        
        self.input = input
        self.output = output
        inputSubscribe()
    }
    
    private func inputSubscribe() {
        
        input.didTapAddAffiliationField
            .bind(onNext: { [weak self] _ in
                
                if self!.affiliationFieldCount < 4 {
                    
                    self?.affiliationFieldCount += 1
                    self?.output
                        .addAffiliationFieldEvent
                        .onNext(self!.affiliationFieldCount)
                }
            })
            .disposed(by: self.disposeBag)
    }
}
