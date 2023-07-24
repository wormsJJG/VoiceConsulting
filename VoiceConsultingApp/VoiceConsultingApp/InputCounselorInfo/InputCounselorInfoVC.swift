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
        setKeyboardObserver()
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
        
        inputCounselorInfoV.selectProfileButton
            .rx
            .tap
            .bind(onNext: { [weak self] _ in
                
                print(#function)
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
// MARK: - DeleteButtonTouchable
extension InputCounselorInfoVC: DeleteButtonTouchable {
    
    func didTapDeleteButton(_ image: UIImage?) {
        
        if let index = viewModel.output.profileImageList.firstIndex(of: image) {
            
            viewModel.output.profileImageList.remove(at: index)
            inputCounselorInfoV.inputProfileImageList.reloadData()
        }
    }
}

// MARK: - CollectionView Delegate, DataSource
extension InputCounselorInfoVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        viewModel.output.profileImageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPhotoCell.cellID, for: indexPath) as? AddPhotoCell else {
                
                return UICollectionViewCell()
            }
            
            cell.configureCell(in: viewModel.output.profileImageList.count - 1)
            
            return cell
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.cellID, for: indexPath) as? PhotoCell else {
                
                return UICollectionViewCell()
            }
            
            cell.deleteDelegate = self
            let image = viewModel.output.profileImageList[indexPath.item]
            cell.configureCell(in: image)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            
            presentImagePicker()
        }
    }
}
// MARK: - ImageFicker Function && Delegate
extension InputCounselorInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
            
            let popUp = CancelImagePickPopUp()
            popUp.hidesBottomBarWhenPushed = true
            popUp.modalPresentationStyle = .overFullScreen
            popUp.modalTransitionStyle = .crossDissolve
            
            self.present(popUp, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // 사진을 선택한 경우
        
        self.dismiss(animated: true) { () in // 창닫기
            
            let selectImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
            self.viewModel.output.profileImageList.append(selectImage)
            self.inputCounselorInfoV.inputProfileImageList.reloadData()
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
