//
//  LoginVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/31.
//

import UIKit
import RxSwift
import RxCocoa

class LoginVC: BaseViewController {
    // MARK: - Load View
    private let loginV = LoginV()
    
    override func loadView() {
        self.view = loginV
    }
    // MARK: - Properties
    private let viewModel = LoginVM()
    private let disposeBag = DisposeBag()
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonAction()
    }
}
// MARK: - Add Button Action
extension LoginVC {
    private func addButtonAction() {
        self.loginV.kakaoLoginButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.viewModel.input.didTapLoginButton.onNext(.kakao)
            })
            .disposed(by: self.disposeBag)
        
        self.loginV.appleLoginButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.viewModel.input.didTapLoginButton.onNext(.apple)
            })
            .disposed(by: self.disposeBag)
        
        self.loginV.googleLoginButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.viewModel.input.didTapLoginButton.onNext(.google)
            })
            .disposed(by: self.disposeBag)
    }
}
