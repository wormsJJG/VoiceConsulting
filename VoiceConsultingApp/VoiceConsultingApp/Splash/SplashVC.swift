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
                    Config.isUser = user.isUser
                    
                    if user.categoryList == nil {
                        self?.moveSelectCategoryVC()
                    } else {
                        self?.moveMain()
                    }
                case .error(let error):
                    print("유저 데이터를 못가져오는거임 네트워크가 없거나 로그인만 해두고 컬렉션엔 데이터가 없음.")
                    print(error.localizedDescription)
                case .completed:
                    print("completed")
                }
            })
            .disposed(by: self.disposeBag)
    }
}

