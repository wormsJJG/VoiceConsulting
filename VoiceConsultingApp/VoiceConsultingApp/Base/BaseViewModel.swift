//
//  BaseViewModel.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/22.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
