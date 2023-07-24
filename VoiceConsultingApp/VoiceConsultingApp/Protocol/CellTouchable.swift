//
//  CellTouchable.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/10.
//

import Foundation

protocol CellTouchable: AnyObject {
    
    func didTouchCell(_ model: Counselor) 
}
