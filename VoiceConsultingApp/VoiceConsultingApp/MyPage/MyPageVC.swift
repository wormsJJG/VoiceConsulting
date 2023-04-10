//
//  MyPageVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit

class MyPageVC: BaseViewController {
    // MARK: - Load View
    private let myPageV = MyPageV()
    
    override func loadView() {
        self.view = myPageV
    }
    // MARK: - Properties
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
