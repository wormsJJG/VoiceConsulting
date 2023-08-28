//
//  ErrorPopUp.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/22.
//

import UIKit

class ErrorPopUp: PopUpVC {
    
    var errorString: String?

    override func setPopUp() {
        super.setPopUp()
        
        self.popUpTitle = "오류"
        self.popUpContent = errorString
        self.isHiddenCancelButton = true
        self.doneButtonTitle = "확인"
        self.doneButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    }
}
