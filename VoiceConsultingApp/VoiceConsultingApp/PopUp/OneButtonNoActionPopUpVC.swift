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
        self.popUpContent = popUpContent
        self.isHiddenCancelButton = true
        self.doneButtonTitle = "확인"
        self.doneButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    }
}
