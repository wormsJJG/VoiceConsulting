//
//  TwoButtonPopUpVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/28.
//

import UIKit

class LogoutPopUpVC: PopUpVC {
    
    override func setPopUp() {
        super.setPopUp()
        self.popUpTitle = "로그아웃 하시겠습니까?"
        self.isHiddenContentLabel = true
        self.cancelButtonTitle = "취소"
        self.doneButtonTitle = "네"
    }
}
