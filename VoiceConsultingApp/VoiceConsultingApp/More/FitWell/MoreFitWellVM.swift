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
        let fitWellCounselorList: PublishSubject<[Counselor]> = PublishSubject()
    }
    
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(),
         output: Output = Output()) {
        
        self.input = input
        self.output = output
        inputSubscribe()
        getFitWellCounselorList()
    }
    
    private func inputSubscribe() {
        
    }
    
    private func getFitWellCounselorList() {
        
        CounselorManager.shared.getFitWellCounselorList(with: 10)
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let counselorList):
                    self?.output.fitWellCounselorList.onNext(counselorList)
                case .error(let error):
                    print(error)
                case .completed:
                    print("onCompleted")
                }
            })
            .disposed(by: self.disposeBag)
    }
}
