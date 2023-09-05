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
        let didTapConsultingButton: PublishSubject<String> = PublishSubject()
    }
    
    struct Output {
        
        let reloadTrigger: PublishSubject<Void> = PublishSubject()
        let section = CounselorInfoSection.allCases
        var counselor: Counselor?
        var reviewList: ReviewList?
        let isHeartCounselor: PublishSubject<Bool> = PublishSubject()
        let completedCheckIsOnline: PublishSubject<Bool> = PublishSubject()
        let errorTrigger: PublishSubject<Error> = PublishSubject()
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
        
        input.didTapConsultingButton
            .bind(onNext: { [weak self] counselorUid in
                
                self?.checkCounselorIsOnline(in: counselorUid)
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
                    
                    self?.output.errorTrigger.onNext(error)
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
                    
                    self?.output.errorTrigger.onNext(error)
                case .completed:
                    print(#function)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func checkCounselorHeart(in counselorUid: String) {
        
        FavouriteManager.shared.checkIsFavorite(in: counselorUid)
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let isHeart):
                    
                    self?.output.isHeartCounselor.onNext(isHeart)
                case .error(let error):
                    
                    self?.output.errorTrigger.onNext(error)
                case .completed:
                    
                    print(#function)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    func didTapHeartButtonAction(in isFavorite: Bool) {
        
        if let counselorUid = output.counselor?.uid {
            
            FavouriteManager.shared.addFavouriteCounselor(isHeart: isFavorite, counselorUid: counselorUid)
                .subscribe({ [weak self] event in
                    
                    switch event {
                        
                    case .next(let isHeart):
                        
                        self?.output.isHeartCounselor.onNext(isHeart)
                        if isHeart {
                            
                            CounselorManager.shared.increaseHeart(in: counselorUid)
                        } else {
                            
                            CounselorManager.shared.decreaseHeart(in: counselorUid)
                        }
                    case .error(let error):
                        
                        self?.output.errorTrigger.onNext(error)
                    case .completed:
                        
                        print(#function)
                    }
                })
                .disposed(by: self.disposeBag)
        }
    }
    
    func checkCounselorIsOnline(in uid: String) {
        
        CounselorManager.shared.getCounselor(in: uid)
            .map { $0.info.isOnline }
            .subscribe(onNext: { [weak self] isOnline in
                
                self?.output.completedCheckIsOnline.onNext(isOnline)
            }, onError: { [weak self] error in
                
                self?.output.errorTrigger.onNext(error)
            })
            .disposed(by: self.disposeBag)
    }
}
