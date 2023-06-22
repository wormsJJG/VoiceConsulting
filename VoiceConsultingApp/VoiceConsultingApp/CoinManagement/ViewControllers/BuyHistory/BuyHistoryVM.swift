//
//  BuyHistoryVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/22.
//

import Foundation
import RxSwift
import RxCocoa

class BuyHistoryVM: BaseViewModel {
    
    struct Input {
        
        let viewDidLoadTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        
        let buyCoinHistoryList: PublishSubject<[BuyCoinHistory]> = PublishSubject()
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
        
        input.viewDidLoadTrigger // Tabman을 사용하면 VC의 init이 빨리 작동되어 didload 를 감지해서 데이터를 뿌림
            .bind(onNext: { [weak self] _ in
                
                self?.getHistory()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func getHistory() {
        
        BuyCoinHistoryManager.shared.getBuyHistoryList()
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let historyList):
                    self?.output.buyCoinHistoryList.onNext(historyList)
                case .error(let error):
                    print(error)
                case .completed:
                    print("completed")
                }
            })
            .disposed(by: self.disposeBag)
    }
}
