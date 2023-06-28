//
//  UseHistoryVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/28.
//

import Foundation
import RxSwift
import RxCocoa

class UseHistoryVM: BaseViewModel {
    
    struct Input {
        
        let viewDidLoadTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        
        let consultingHistoryList: PublishSubject<ConsultingList> = PublishSubject()
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
        
        input.viewDidLoadTrigger
            .bind(onNext: { [weak self] _ in
                
                self?.getConsultingHistoryList()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func getConsultingHistoryList() {
        
        ConsultingHistoryManager.shared.getConsultingHistoryList()
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let historyList):
                    self?.output.consultingHistoryList.onNext(historyList)
                case .error(let error):
                    print(error)
                case .completed:
                    print("completed")
                }
            })
            .disposed(by: self.disposeBag)
    }
}
