//
//  StartConsultingPopUp.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/18.
//

import UIKit
import RxCocoa
import RxSwift

class NoOnlineCounselorPopUp: PopUpVC {

    private let disposeBag = DisposeBag()
    
    override func setPopUp() {
        super.setPopUp()
        
        self.popUpTitle = "안내"
        self.popUpContent = "실시간 상담이 불가능한 상담사입니다.\n채팅으로 상담예약을 하시겠습니까?"
        self.isHiddenCancelButton = false
        self.doneButtonTitle = "채팅하기"
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
