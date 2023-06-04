//
//  LiveCellVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/09.
//

import Foundation
import RxSwift

class LiveCellVM: BaseViewModel {
    
    struct Input {
        let refreshTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        let onlineCounselorList: PublishSubject<[Counselor]> = PublishSubject()
    }
    
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        getOnlineCounselorList()
    }
    
    private func inputSubscribe() {
        self.input.refreshTrigger.subscribe(onNext: { [weak self] _ in
            self?.getOnlineCounselorList()
        })
        .disposed(by: self.disposeBag)
    }
    
    func getOnlineCounselorList() {
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
