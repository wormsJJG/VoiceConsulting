//
//  MainVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/26.
//

import UIKit
import RxSwift
import RxCocoa

class MainVC: BaseViewController {
    // MARK: - Load View
    private let mainV = MainV()
    
    override func loadView() {
        self.view = MainV()
    }
    // MARK: - properties
    private let viewModel = MainVM()
    private let disposeBag = DisposeBag()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Main" //임시
        isHiddenNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isHiddenBackButton()
    }
}
