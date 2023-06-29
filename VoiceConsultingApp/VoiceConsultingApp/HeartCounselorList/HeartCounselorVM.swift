//
//  HeartCounselorVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/29.
//

import Foundation
import RxSwift

class HeartCounselorVM: BaseViewModel {
    
    struct Input {
        
        let favoriteList: PublishSubject<[String]> = PublishSubject()
    }
    
    struct Output {
        
        let counselorList: PublishSubject<[Counselor]> = PublishSubject()
    }
    
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(),
         output: Output = Output()) {
        
        self.input = input
        self.output = output
        inputSubscribe()
        getHeartList()
    }
    
    private func inputSubscribe() {
        
        self.input.favoriteList
            .bind(onNext: { [weak self] counselorUidList in
                
                self?.convertUidToCounselor(counselorUidList)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func getHeartList() {
        
        FavouriteManager.shared.getFavouriteList()
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let favoriteList):
                    
                    self?.input.favoriteList.onNext(favoriteList.map { $0.targetId })
                case .error(let error):
                    
                    print(error)
                case .completed:
                    print(#function)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func convertUidToCounselor(_ uidList: [String]) {
        
        CounselorManager.shared.convertUidToCounselor(in: uidList)
            .subscribe({ [weak self] event in
                
                switch event {
    
                case .next(let counselorList):
                    
                    self?.output.counselorList.onNext(counselorList)
                case .error(let error):
                    
                    print(error)
                case .completed:
                    
                    print(#function)
                }
            })
            .disposed(by: self.disposeBag)
    }
}
