//
//  CounselorDetailVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/29.
//

import UIKit

class CounselorDetailVC: BaseViewController {
    // MARK: - Load View
    private let counselorDetailV = CounselorDetailV()
    
    override func loadView() {
        self.view = counselorDetailV
    }
    // MARK: - Properties
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
