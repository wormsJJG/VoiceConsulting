//
//  CancelImagePickPop.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/24.
//

import UIKit

class CancelImagePickPopUp: PopUpVC {

    override func setPopUp() {
        super.setPopUp()
        
        self.popUpTitle = "안내"
        self.popUpContent = "사진 선택이 취소되었습니다."
        self.isHiddenCancelButton = true
        self.doneButtonTitle = "확인"
        self.doneButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    }
}
