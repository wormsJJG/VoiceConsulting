//
//  GIDManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/04.
//

import Foundation
import RxSwift
import GoogleSignIn
import FirebaseAuth

class GoogleLoginService {
    static let shared = GoogleLoginService()
    
    func signIn(viewController: UIViewController) -> Observable<AuthDataResult?> {
        return Observable.create { event in
            
            GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { signInResult, error in
                if let error {
                    
                    event.onError(error)
                } else {
                    
                    guard let idToken = signInResult?.user.idToken,
                          let accessToken = signInResult?.user.accessToken else { return }
                    let credenital = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
                    
                    Auth.auth().signIn(with: credenital) { authResult, error in
                        
                        if let error {
                            
                            event.onError(error)
                        } else {
                            event.onNext(authResult)
                            event.onCompleted()
                        }
                    }
                }
            }
            return Disposables.create()
        }
    }
}
