//
//  BuyCoinVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import UIKit

class BuyCoinVC: BaseViewController {
    // MARK: - Load View
    private let buyCoinV = BuyCoinV()
    
    override func loadView() {
        self.view = buyCoinV
    }
    // MARK: - Properites
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
