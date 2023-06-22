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
                self?.navigationController?.pushViewController(SelectUseTypeVC(), animated: true)
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
                self?.googleLogin()
            })
            .disposed(by: self.disposeBag)
    }
}

extension LoginVC {
    // GoogleLogin은 viewController를 넘겨야해서 VC에 함수
    private func googleLogin() {
        
        GoogleSignInManager.shared.signIn(viewController: self)
            .subscribe(onNext: { [weak self] authResult in
                if let authResult {
                    
                    self?.checkFisrtLoginCheck(uid: authResult.user.uid,
                                               name: authResult.user.displayName ?? "user")
                } else {
                    print("optional AuthResult")
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func checkFisrtLoginCheck(uid: String, name: String) {
        
        UserManager.shared.checkField(uid: uid)
            .subscribe(onNext: { [weak self] isLogined in
                
                if isLogined {
                    
                    self?.moveSplashVC()
                } else {
                    
                    self?.createField(name: name, uid: uid)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func createField(name: String, uid: String) {
        
        UserManager.shared.createUserUidField(name: name, uid: uid)
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next():
                    self?.moveSelectUseTypeVC()
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    print("completed")
                }
            })
            .disposed(by: self.disposeBag)
    }
}
