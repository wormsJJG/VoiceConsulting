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
        
        UserManager.shared.getCurrentUserData()
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let user):
                    Config.name = user.name
                    
                    if user.isUser == nil {
                        self?.moveSelectUseTypeVC()
                    } else if user.categoryList == nil {
                        
                        Config.isUser = user.isUser!
                        self?.moveSelectCategoryVC()
                    } else {
                        
                        Config.isUser = user.isUser!
                        self?.viewModel.saveCategory()
//                        self?.moveMain()
                        self?.moveVoiceRoom()
                    }
                    
                case .error(let error):
                    
                    self?.moveLoginVC()
                    print(error.localizedDescription)
                case .completed:
                    print("completed")
                }
            })
            .disposed(by: self.disposeBag)
    }
}

