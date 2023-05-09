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
        let onlineCounselorList: PublishSubject<[Counselor]> = PublishSubject()
    }
    
    var input: Input
    var output: Output
    var sectionTitleList = Observable.of(MainListSection.allCases)
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        getOnlineCounselorList()
    }
    
    private func getOnlineCounselorList() { 
        CounselorManager.shared.getOnlineCounselorList()
            .subscribe({ [weak self] event in
                switch event {
                case .next(let counselorList):
                    self?.output.onlineCounselorList.onNext(counselorList)
                case .error(let error):
                    print("\(#function) \(error.localizedDescription)")
                case .completed:
                    print("onCompleted")
                }
            })
            .disposed(by: self.disposeBag)
    }
}
