//
//  StarScorePicker.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/28.
//

import UIKit
import Cosmos

protocol StarScorePickerDelegate: NSObject {
    func didChangeScore(score: Double)
}

class StarScorePicker: CosmosView {
    weak var delegate: StarScorePickerDelegate?
    
    override var rating: Double {
        didSet {
            delegate?.didChangeScore(score: rating)
        }
    }
}
