//
//  SelectUseTypeVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/27.
//

import UIKit
import RxSwift
import RxCocoa

class SelectUseTypeVC: BaseViewController {
    // MARK: - Load View
    private let selectUseTypeV = SelectUseTypeV()
    
    override func loadView() {
        self.view = selectUseTypeV
    }
    // MARK: - Properties
    private let viewModel = SelectUseTypeVM()
    private let disposeBag = DisposeBag()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        outputSubscribe()
        addButtonAction()
        isHiddenNavigationBar()
    }
}
// MARK: -
extension SelectUseTypeVC {
    
    private func outputSubscribe() {
        
        self.viewModel.output.isSuccess
            .bind(onNext: { [weak self] isSuccess in
                if isSuccess {
                    self?.moveSelectCategoryVC()
                }
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - Button Action
extension SelectUseTypeVC {
    
    private func addButtonAction() {
        
        self.selectUseTypeV.userButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.viewModel.input.selectUseType.onNext(UseType.user)
            })
            .disposed(by: self.disposeBag)
        
        self.selectUseTypeV.counselorButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.viewModel.input.selectUseType.onNext(UseType.counselor)
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.input.selectUseType
            .subscribe(onNext: { [weak self] useType in
                self?.selectUseTypeV.clickAction(useType: useType)
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.isNextButtonEnable
            .subscribe(onNext: { [weak self] isEnable in
                self?.selectUseTypeV.nextButton.isEnabled = isEnable
            })
            .disposed(by: self.disposeBag)
        
        self.selectUseTypeV.nextButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.viewModel.input.didTapNextButton.onNext(self!.selectUseTypeV.isUser)
            })
            .disposed(by: self.disposeBag)
    }
}
