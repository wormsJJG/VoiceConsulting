//
//  NoPassRegisterPopUp.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/07.
//

import UIKit

class NoPassRegisterPopUp: PopUpVC {

    override func setPopUp() {
        super.setPopUp()
        
        self.popUpTitle = "안내"
        self.popUpContent = "상담사 정보를 제대로 입력하지 않으셨습니다."
        self.isHiddenCancelButton = true
        self.doneButtonTitle = "확인"
        self.doneButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    }
}
