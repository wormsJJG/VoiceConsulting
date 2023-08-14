//
//  NoPassToSettlePopUp.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/14.
//

import UIKit

class NoPassToSettlePopUp: PopUpVC {

    override func setPopUp() {
        super.setPopUp()
        
        self.popUpTitle = "안내"
        self.popUpContent = "정보를 제대로 입력하지 않으셨습니다."
        self.isHiddenCancelButton = true
        self.doneButtonTitle = "확인"
        self.doneButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    }
}
