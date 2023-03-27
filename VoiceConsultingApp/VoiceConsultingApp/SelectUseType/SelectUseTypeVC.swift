//
//  SelectUseTypeVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/27.
//

import UIKit
import RxSwift
import RxCocoa

class SelectUseTypeVC: BaseViewController {
    // MARK: - Load View
    private let selectUseTypeV = SelectUseTypeV()
    
    override func loadView() {
        self.view = selectUseTypeV
    }
    // MARK: - Properties
    private let viewModel = SelectUseTypeVM()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
