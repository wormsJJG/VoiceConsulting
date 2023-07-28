//
//  SplashVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/23.
//

import Foundation
import RxSwift
import RxCocoa

class SplashVM: BaseViewModel {
    
    struct Input {
        let isEnterUser: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        let isLogin: PublishSubject<Bool> = PublishSubject()
    }
    
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output()) {
        self.input = input
        self.output = output
        inputSubscribe()
    }
    
    //Subscribing
    private func inputSubscribe() {
        input.isEnterUser
            .subscribe(onNext: { [weak self] _ in
                // 로그인 검사
                self?.output.isLogin.onNext(FirebaseAuthManager.shared.isLogin)
            })
            .disposed(by: self.disposeBag)
    }
    
    func saveCategory() {
        
//        CategoryManager.shared.getCategoryList()
//            .subscribe({ event in
//
//                switch event {
//
//                case .next(let categoryList):
//                    CategoryManager.categoryData = categoryList
//                case .error(let error):
//                    print(error)
//                case .completed:
//                    print(#function)
//                }
//            })
//            .disposed(by: self.disposeBag)
    }
}
