//
//  WriteReviewVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/26.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class WriteReviewVC: BaseViewController {
    // MARK: - LoadView
    private let writeReviewV = WriteReviewV()
    
    override func loadView() {
        super.loadView()
        self.view = writeReviewV
    }
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addAction()
        setKeyboardObserver()
        setDelegates()
    }
    // MARK: - SetDelegates
    private func setDelegates() {
        self.writeReviewV.reviewField.delegate = self
        self.writeReviewV.starScorePicker.delegate = self
    }
}
// MARK: - AddAction
extension WriteReviewVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func addAction() {
        self.writeReviewV.header.backButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.popVC()
            })
            .disposed(by: self.disposeBag)
        
        self.writeReviewV.starScorePicker.didFinishTouchingCosmos.map { score in
            print(score)
        }
    }
}
// MARK: - TextViewDelegate
extension WriteReviewVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == ColorSet.subTextColor2 else { return }
        textView.textColor = ColorSet.mainText
        textView.text = nil
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "리뷰작성하기"
            textView.textColor = ColorSet.subTextColor2
        }
    }
}
// MARK: - StarScorePickerDelegate
extension WriteReviewVC: StarScorePickerDelegate {
    func didChangeScore(score: Double) {
        self.writeReviewV.updateStarScoreLabel(score: score)
    }
}
