//
//  LoginVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/31.
//

import UIKit
import RxSwift
import RxCocoa
import AuthenticationServices
import CryptoKit
import FirebaseAuth

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
                self?.signInApple()
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
        
        GoogleLoginService.shared.signIn(viewController: self)
            .subscribe(onNext: { [weak self] authResult in
                if let authResult {
                    
                    self?.checkFisrtLogin(uid: authResult.user.uid,
                                               name: authResult.user.displayName)
                } else {
                    print("optional AuthResult")
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func checkFisrtLogin(uid: String, name: String?) {
        
        Observable.combineLatest(UserManager.shared.checkField(uid: uid),
                                 CounselorManager.shared.checkField(uid: uid))
        .subscribe({ [weak self] event in
            
            switch event {
                
            case .next((let userLogined, let counselorLogined)):
                
                if userLogined || counselorLogined {
                    
                    self?.moveSplashVC()
                } else {
                    
                    UserRegisterData.uid = uid
                    UserRegisterData.name = name
                    self?.moveSelectUseTypeVC()
                }
            case .error(let error):
                
                print(error.localizedDescription)
            case .completed:
                
                print("completed")
            }
        })
        .disposed(by: self.disposeBag)
    }
}
// MARK: - Apple Login
extension LoginVC: ASAuthorizationControllerDelegate {
    
    private func signInApple() {
        
        let nonce = String().randomNonceString()
        viewModel.currentNonce = nonce
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        
        request.requestedScopes = [.fullName, .email]
        request.nonce = String().sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // controller로 인증 정보 값을 받게되면, idToken 값을 받음
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            guard let nonce = viewModel.currentNonce,
                  let appleIDToken = appleIDCredential.identityToken,
                  let idTokenString = String(data: appleIDToken, encoding: .utf8) else { return }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                
                if let error = error {
                    
                    print(error.localizedDescription)
                    return
                }
                
                if let result = authResult {
                    
                    let fullName = appleIDCredential.fullName
                    
                    guard let familyName = fullName?.familyName,
                          let givenName = fullName?.givenName else {
                        
                        self.checkFisrtLogin(uid: result.user.uid, name: nil)
                        return
                    }
                    let name = (familyName) + (givenName)
                    self.checkFisrtLogin(uid: result.user.uid, name: name)
                }
            }
        }
    }
}

extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        guard let window = self.view.window else {
            
           return ASPresentationAnchor()
        }
        
        return window
    }
}
