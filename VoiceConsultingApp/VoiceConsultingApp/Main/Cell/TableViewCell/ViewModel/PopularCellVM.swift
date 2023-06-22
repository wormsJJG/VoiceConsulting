//
//  PopularCellVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/15.
//

import Foundation
import RxSwift

class PopularCellVM: BaseViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        let popularCounselorList: PublishSubject<[Counselor]> = PublishSubject()
    }
    
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(),
         output: Output = Output()) {
        
        self.input = input
        self.output = output
        getPopularCounselorList()
    }
}

extension PopularCellVM {
    
    private func getPopularCounselorList() {
        
        CounselorManager.shared.getPopularCounselorList(with: 10)
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let counselorList):
                    self?.output.popularCounselorList.onNext(counselorList)
                case .error(let error):
                    print(error)
                case .completed:
                    print("onCompleted")
                }
            })
            .disposed(by: self.disposeBag)
    }
}
