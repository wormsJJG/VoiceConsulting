//
//  CounselorDetailVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/19.
//

import Foundation
import RxSwift
import RxCocoa

class CounselorDetailVM: BaseViewModel {
    
    struct Input {
        let getDataTrigger: PublishSubject<String> = PublishSubject()
    }
    
    struct Output {
        let reloadTrigger: PublishSubject<Void> = PublishSubject()
        let section = CounselorInfoSection.allCases
        var counselor: Counselor?
        var reviewList: ReviewList?
        let isHeartCounselor: PublishSubject<Bool> = PublishSubject()
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
        
        input.getDataTrigger
            .subscribe(onNext: { [weak self] counselorUid in
                
                self?.getCounselor(uid: counselorUid)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func getCounselor(uid: String) {
        
        CounselorManager.shared.getCounselor(in: uid)
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let counselor):
                    
                    self?.output.counselor = counselor
                    self?.output.reloadTrigger.onNext(())
                    self?.getCounselorReview(uid: counselor.uid)
                    self?.checkCounselorHeart(in: counselor.uid)
                case .error(let error):
                    
                    print(error)
                case .completed:
                    
                    print(#function)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func getCounselorReview(uid: String) {
        
        ReviewManager.shared.getReviewList(in: uid)
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let reviewList):
                    
                    self?.output.reviewList = reviewList
                    self?.output.reloadTrigger.onNext(())
                case .error(let error):
                    
                    print(error)
                case .completed:
                    print(#function)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func checkCounselorHeart(in counselorUid: String) {
        
        HeartManager.shared.checkIsHeart(in: counselorUid)
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let isHeart):
                    
                    self?.output.isHeartCounselor.onNext(isHeart)
                case .error(let error):
                    
                    print(error.localizedDescription)
                case .completed:
                    
                    print(#function)
                }
            })
            .disposed(by: self.disposeBag)
    }
}
