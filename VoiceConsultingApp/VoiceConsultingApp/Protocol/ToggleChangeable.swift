//
//  ToggleChangeable.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/15.
//

import Foundation

protocol ToggleChangeable: AnyObject {
    
    func didChange(isOn: Bool, menuType: MypageCounselorMenu)
}
