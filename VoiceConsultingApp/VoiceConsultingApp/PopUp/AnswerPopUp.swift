//
//  AnswerPopUp.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/23.
//

import UIKit
import RxSwift
import RxCocoa

class AnswerPopUp: PopUpVC {

    private let disposeBag = DisposeBag()
    
    override func setPopUp() {
        super.setPopUp()
        
        self.popUpTitle = popUpTitle
        self.popUpContent = popUpContent
        self.isHiddenCancelButton = false
        self.cancelButtonTitle = "아니요"
        self.doneButtonTitle = "예"
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
