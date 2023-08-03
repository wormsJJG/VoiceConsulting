//
//  SplashVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/22.
//

import UIKit
import RxSwift
import RxCocoa

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
        outputSubscrbe()
        self.viewModel.input.isEnterUser.onNext(())
    }
}

extension SplashVC {
    // 유저 검증 (로그인이 되어있는지 안되어 있는지 검증)
    private func outputSubscrbe() {
        self.viewModel.output.pushMainVCTrigger
            .bind(onNext: { [weak self] isLogin in
                
                self?.moveMain()
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.isNoLogin
            .bind(onNext: { [weak self] _ in
                
                self?.moveLoginVC()
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.pushSelectUseTypeVCTrigger
            .bind(onNext: { [weak self] _ in
                
                self?.moveSelectUseTypeVC()
            })
            .disposed(by: self.disposeBag)
    }
}

