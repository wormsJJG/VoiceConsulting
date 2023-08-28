//
//  TwoButtonPopUpVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/28.
//

import UIKit
import RxSwift

class LogoutPopUpVC: PopUpVC {
    
    private let disposeBag = DisposeBag()
    
    override func setPopUp() {
        super.setPopUp()
        self.popUpTitle = "로그아웃 하시겠습니까?"
        self.isHiddenContentLabel = true
        self.cancelButtonTitle = "취소"
        self.doneButtonTitle = "네"
        self.doneButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
    }
    
    @objc private func logout() {
        FirebaseAuthManager.shared.logout()
        AgoraManager.shared.logout()
            .subscribe(onNext: { [weak self] _ in
                
                self?.moveLoginVC()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func moveLoginVC() {
        let loginVC = UINavigationController(rootViewController: LoginVC()) 
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(vc: loginVC)
    }
}
