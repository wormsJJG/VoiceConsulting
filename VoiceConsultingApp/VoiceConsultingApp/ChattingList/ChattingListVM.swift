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
        
        let fetchChattingListTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        
        let channelList: PublishSubject<[ChatChannel]> = PublishSubject()
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
        
        input.fetchChattingListTrigger
            .bind(onNext: { [weak self] _ in
                
                self?.fetchChatChannelList()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func fetchChatChannelList() {
        
        ChatChannelStorage.shared.fetchChatChanelList()
            .subscribe(onNext: { [weak self] list in
                
                self?.output.channelList.onNext(list)
            })
            .disposed(by: self.disposeBag)
    }
}
