//
//  TermsVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/22.
//

import UIKit
import RxSwift
import RxCocoa

class TermsVC: BaseViewController {
    // MARK: - load View
    private let termsV = TermsV()
    
    override func loadView() {
        super.loadView()
        self.view = termsV
    }
    // MARK: - Properties
    var type: HeaderType = .termsOfUse {
        didSet {
            self.termsV.header.headerType = type
            if type == .privacyPolicy {
                self.termsV.termsLabel.text = TermsContent.privacyPolivy
            } else {
                self.termsV.termsLabel.text = TermsContent.termsOfUseContent
            }
        }
    }
    private let disposeBag = DisposeBag()
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.termsV.header.backButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.popVC()
            })
            .disposed(by: self.disposeBag)
    }
}
