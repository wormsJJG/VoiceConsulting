//
//  SelectCategoryVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/30.
//

import Foundation
import RxSwift
import RxCocoa

class SelectCategoryVM: BaseViewModel {
    
    struct Input {
        var userSelectCategoryList: [String] = []
        var didTapCompleteButton: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        let categoryList: PublishSubject<[CategoryType]> = PublishSubject()
    }
    
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        inputSubscribe()
        getCategoryList()
    }
    
    private func inputSubscribe() {
        self.input.didTapCompleteButton
            .filter { !self.input.userSelectCategoryList.isEmpty }
            .bind(onNext: { [weak self] _ in
                print(self!.input.userSelectCategoryList)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func getCategoryList() {
        
        CategoryManager.shared.getCategoryList()
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let categoryList):
                    self?.output.categoryList.onNext(categoryList)
                case .error(let error):
                    print(error)
                case .completed:
                    print("onCompleted")
                }
            })
            .disposed(by: self.disposeBag)
    }
}
