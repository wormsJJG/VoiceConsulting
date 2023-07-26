//
//  SplashVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/22.
//

import UIKit
import RxSwift

class SplashVC: BaseViewController {
    // MARK: - Load View
    private let splashV = SplashV()
    
    override func loadView() {
        self.view = splashV
    }
    // MARK: - Properties
    private let viewModel = SplashVM()
    private let disposeBag = DisposeBag()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        userLoginCheck()
        self.viewModel.input.isEnterUser.onNext(())
    }
}

extension SplashVC {
    // 유저 검증 (로그인이 되어있는지 안되어 있는지 검증)
    private func userLoginCheck() {
        self.viewModel.output.isLogin
            .subscribe(onNext: { [weak self] isLogin in
                if isLogin {
                    self?.userDataCheck()
                } else {
                    
                    self?.moveLoginVC()
                }
            })
            .disposed(by: self.disposeBag)
    }
    // 유저 데이터 유무 체크 유저가 회원가입 도중 중단했을경우를 생각
    private func userDataCheck() {
        
        let isUser = CheckDataManager.shared.getIsUser()
        let isInputInfo = CheckDataManager.shared.getIsInputInfo()
        let name = CheckDataManager.shared.getName()
        
        if isInputInfo {
            
            Config.isUser = isUser
            Config.name = name
            self.viewModel.saveCategory()
            self.moveMain()
        } else {
            
            self.moveSelectUseTypeVC()
        }
    }
}

