//
//  OneButtonNoActionPopUpVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/05.
//

import UIKit

class OneButtonNoActionPopUpVC: PopUpVC {
    
    
    override func setPopUp() {
        super.setPopUp()
        self.popUpTitle = "안내"
        self.popUpContent = "상담사는 상담이 불가능합니다."
        self.isHiddenCancelButton = true
        self.doneButtonTitle = "확인"
        self.doneButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    }
}
