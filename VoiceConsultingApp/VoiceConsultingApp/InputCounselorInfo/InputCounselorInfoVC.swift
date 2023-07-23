//
//  InputCounselorInfoVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/20.
//

import UIKit
import RxSwift
import RxCocoa

class InputCounselorInfoVC: BaseViewController {
    
    // MARK: - Load View
    private let inputCounselorInfoV = InputCounselorInfoV()
    
    override func loadView() {
        super.loadView()
        
        self.view = inputCounselorInfoV
    }
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel = InputCounselorInfoVM()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegates()
        outputSubscribe()
        addAction()
//        setKeyboardObserver()
    }
    
    // MARK: - SetDelegates
    private func setDelegates() {
        
        inputCounselorInfoV.inputProfileImageList.dataSource = self
        inputCounselorInfoV.inputProfileImageList.delegate = self
        inputCounselorInfoV.inputIntroduceField.delegate = self
        inputCounselorInfoV.inputNameTextField.delegate = self
        inputCounselorInfoV.affiliationTextFieldOne.delegate = self
        inputCounselorInfoV.affiliationTextFieldTwo.delegate = self
        inputCounselorInfoV.affiliationTextFieldThree.delegate = self
        inputCounselorInfoV.affiliationTextFieldFour.delegate = self
    }
}
// MARK: - Add Action
extension InputCounselorInfoVC {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    private func addAction() {
        
        inputCounselorInfoV.addAffiliationFieldButton
            .rx
            .tap
            .bind(onNext: { [weak self] _ in
                
                self?.viewModel.input.didTapAddAffiliationField.onNext(())
            })
            .disposed(by: self.disposeBag)
    }
}
// MARK: - Output Subscribe
extension InputCounselorInfoVC {
    
    private func outputSubscribe() {
        
        viewModel.output.addAffiliationFieldEvent
            .bind(onNext: { [weak self] fieldCount in
                
                switch fieldCount {
                    
                case 2:
                    
                    self?.inputCounselorInfoV
                        .affiliationTextFieldTwo.isHidden = false
                case 3:
                    
                    self?.inputCounselorInfoV
                        .affiliationTextFieldThree.isHidden = false
                case 4:
                    
                    self?.inputCounselorInfoV
                        .affiliationTextFieldFour.isHidden = false
                default:
                    
                    return
                }
            })
            .disposed(by: self.disposeBag)
    }
}

// MARK: - CollectionView Delegate, DataSource
extension InputCounselorInfoVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        viewModel.output.profileImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPhotoCell.cellID, for: indexPath) as? AddPhotoCell else {
                
                return UICollectionViewCell()
            }
            
            return cell
        } else {
            
            return UICollectionViewCell()
        }
    }
}
// MARK: - TextViewDelegate
extension InputCounselorInfoVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
// MARK: - TextViewDelegate
extension InputCounselorInfoVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        guard textView.textColor == ColorSet.subTextColor2 else { return }
        textView.textColor = ColorSet.mainText
        textView.text = nil
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if textView.text.isEmpty {
            textView.text = "상세 소개를 작성해주세요"
            textView.textColor = ColorSet.subTextColor2
        }
    }
}
