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
        
        let refreshLiveCounselorTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        
        let mainSectionList: BehaviorRelay<[MainSectionModel]> = BehaviorRelay(value: [])
        let errorTrigger: PublishSubject<Error> = PublishSubject()
    }
    
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    private let liveCounselor = CounselorManager.shared.getOnlineCounselorList(with: 10)
    private let popularCounselor = CounselorManager.shared.getPopularCounselorList(with: 10)
    private let fitWellCounselor = CounselorManager.shared.getFitWellCounselorList(with: 10)
    
    init(input: Input = Input(),
         output: Output = Output()) {
        
        self.input = input
        self.output = output
        inputSubscribe()
        fetchMainSectionList()
    }
    
    private func inputSubscribe() {
        
        input.refreshLiveCounselorTrigger
            .bind(onNext: { [weak self] _ in
                
                self?.refreshLiveCounselor()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func fetchMainSectionList() {
        
        let zip = Observable.zip(liveCounselor, popularCounselor, fitWellCounselor)
        
        zip
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
        .subscribe({ [weak self] event in
        
            switch event {
            case .next((let live, let popular, let fitWell)):
                
                let banner = MainSectionModel(sectionType: .banner, sectionItems: [])
                let liveSection = MainSectionModel(sectionType: .liveCounselor, sectionItems: live)
                let popularSection = MainSectionModel(sectionType: .popularCounselor, sectionItems: popular)
                let fitWell = MainSectionModel(sectionType: .fitWellCounselor, sectionItems: fitWell)
                
                self?.output.mainSectionList.accept([banner, liveSection, popularSection, fitWell])
            case .error(let error):
                
                self?.output.errorTrigger.onNext(error)
            case .completed:
                
                print(#function)
            }
        })
        .disposed(by: self.disposeBag)
    }
    
    private func refreshLiveCounselor() {
        
        var sectionList = output.mainSectionList.value
        
        liveCounselor
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let counselorList):
                    
                    sectionList[1] = .init(sectionType: .liveCounselor, sectionItems: counselorList)
                    self?.output.mainSectionList.accept(sectionList)
                case .error(let error):
                    
                    self?.output.errorTrigger.onNext(error)
                case .completed:
                    
                    print(#function)
                }
            })
            .disposed(by: self.disposeBag)
    }
}
