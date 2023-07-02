//
//  HeartCounselorVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/29.
//

import Foundation
import RxSwift
import RxCocoa

class HeartCounselorVM: BaseViewModel {
    
    struct Input {
        
        
    }
    
    struct Output {
        
        let favoriteList: PublishSubject<[String]> = PublishSubject()
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
        
//        self.input.favoriteList
//            .bind(onNext: { [weak self] counselorUidList in
//
//                self?.convertUidListToCounselorList(counselorUidList)
//            })
//            .disposed(by: self.disposeBag)
    }
    
    private func getHeartList() {
        
        FavouriteManager.shared.getFavouriteList()
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let favoriteList):
                    
                    self?.output.favoriteList.onNext(favoriteList.map { $0.targetId })
                case .error(let error):
                    
                    print(error)
                case .completed:
                    print(#function)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
//    private func convertUidListToCounselorList(_ uidList: [String]) {
//        var value = self.output.counselorList.value
//        for uid in uidList {
//            
//            CounselorManager.shared.getCounselor(in: uid)
//                .subscribe({ [weak self] event in
//                    
//                    switch event {
//                        
//                    case .next(let counselor):
//                        
//                        self?.output.counselorList.value.append(counselor)
//                    case .error(let error):
//                        
//                        print(error)
//                    case .completed:
//                        
//                        print(#function)
//                    }
//                })
//                .disposed(by: self.disposeBag)
//        }
//        self.output.counselorList.accept(value)
//    }
}
