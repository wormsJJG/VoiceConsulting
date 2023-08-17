//
//  InputUserInfoVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/17.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class InputUserInfoVC: BaseViewController {

    // MARK: - Load View
    private let inputUserInfoV = InputUserInfoV()
    
    override func loadView() {
        super.loadView()
        
        self.view = inputUserInfoV
    }
    
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel = InputUserInfoVM()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingNameField()
        setDelegates()
        addAction()
    }
    
    // MARK: - View Mode
//    func isEditInfo() {
//
//        inputCounselorInfoV.header.headerType = .editCounselorInfo
//        viewModel.input.isEditInfo.onNext(())
//    }
    
    private func setDelegates() {
        
        self.inputUserInfoV.inputNameTextField.delegate = self
    }
    
    private func settingNameField() {
        
        if UserRegisterData.name != "" {
            
            self.inputUserInfoV.inputNameTextField.text = UserRegisterData.name
        }
    }
}

// MARK: - Add Action
extension InputUserInfoVC {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    private func addAction() {
        
        inputUserInfoV.header.backButton
            .rx
            .tap
            .bind(onNext: { [weak self] _ in
                
                self?.popVC()
            })
            .disposed(by: self.disposeBag)
        
        inputUserInfoV.profileImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                
                self?.presentImagePicker()
            })
            .disposed(by: self.disposeBag)
        
        inputUserInfoV.selectProfileButton
            .rx
            .tap
            .bind(onNext: { [weak self] _ in
                
                self?.presentImagePicker()
            })
            .disposed(by: self.disposeBag)
        
        inputUserInfoV.nextButton
            .rx
            .tap
            .bind(onNext: { [weak self] _ in
                
                self?.didTapCompleteButton()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func didTapCompleteButton() {
        
        if inputUserInfoV.inputNameTextField.text!.isEmpty {
            
            showPopUp(popUp: NoPassUserRegisterPopUp())
        } else {
            
            UserRegisterData.isUser = true
            UserRegisterData.name = inputUserInfoV.inputNameTextField.text!
            UserRegisterData.profileImage = inputUserInfoV.profileImageView.image ?? UIImage(named: AssetImage.defaultProfileImage)
            moveSelectCategoryVC()
        }
    }
}
// MARK: - ImageFicker Function && Delegate
extension InputUserInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private func presentImagePicker() {
        
        let picker = UIImagePickerController()
        
        picker.sourceType = .photoLibrary // 앨범에서 사진을 선택
        picker.allowsEditing = true // 편집 가능
        picker.delegate = self
        
        self.present(picker, animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // 사진을 선택하지않고 취소한 경우
        
        self.dismiss(animated: true) { () in // 창 닫기
            
            self.showPopUp(popUp: CancelImagePickPopUp())
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 사진을 선택한 경우
        
        self.dismiss(animated: true) { () in // 창닫기
            
            let selectImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
                
            self.inputUserInfoV.profileImageView.image = selectImage
        }
    }
}
// MARK: - TextViewDelegate
extension InputUserInfoVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
}
 
