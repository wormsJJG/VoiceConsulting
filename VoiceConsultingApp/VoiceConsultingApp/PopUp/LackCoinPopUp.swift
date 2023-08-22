//
//  LackCoinPopUp.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/23.
//

import UIKit
import RxSwift

class LackCoinPopUp: PopUpVC {

    private let disposeBag = DisposeBag()
    
    override func setPopUp() {
        super.setPopUp()
        
        self.popUpTitle = "안내"
        self.popUpContent = "가지고 계신 코인이 부족합니다.\n코인을 충전하러 가시겠습니까?"
        self.isHiddenCancelButton = false
        self.doneButtonTitle = "충전하기"
    }
    
    func setCallBack(didTapOkButtonCallBack: @escaping (() -> Void)) {
        
        doneButton.rx.tap
            .bind(onNext: { [weak self] _ in
                
                didTapOkButtonCallBack()
                self?.dismiss(animated: true)
            })
            .disposed(by: self.disposeBag)
    }
}
