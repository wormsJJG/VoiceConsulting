//
//  DeleteAccountPopUpVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/28.
//

import UIKit

class DeleteAccountPopUpVC: PopUpVC {

    override func setPopUp() {
        super.setPopUp()
        self.popUpTitle = "정말 회원탈퇴를 하시겠습니까?"
        self.popUpContent = "회원탈퇴를 하게되면 회원님의\n모든 데이터가 사라집니다."
        self.cancelButtonTitle = "취소"
        self.doneButtonTitle = "네,탈퇴합니다."
    }
}
