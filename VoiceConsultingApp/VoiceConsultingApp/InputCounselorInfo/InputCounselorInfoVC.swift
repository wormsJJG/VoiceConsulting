//
//  InputCounselorInfoVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/20.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

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
    
    private func addAction() {
        
        inputCounselorInfoV.header.backButton
            .rx
            .tap
            .bind(onNext: { [weak self] _ in
                
                self?.popVC()
            })
            .disposed(by: self.disposeBag)
        
        inputCounselorInfoV.addAffiliationFieldButton
            .rx
            .tap
            .bind(onNext: { [weak self] _ in
                
                self?.viewModel.input.didTapAddAffiliationField.onNext(())
            })
            .disposed(by: self.disposeBag)
        
        inputCounselorInfoV.profileImageView
            .rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                
                self?.viewModel.isSelectProfile = true
                self?.presentImagePicker()
            })
            .disposed(by: self.disposeBag)
        
        inputCounselorInfoV.selectProfileButton
            .rx
            .tap
            .bind(onNext: { [weak self] _ in
                
                self?.viewModel.isSelectProfile = true
                self?.presentImagePicker()
            })
            .disposed(by: self.disposeBag)
        
        addDidTapScrollViewAction()
        
        inputCounselorInfoV
            .inputIntroduceField
            .rx
            .didBeginEditing
            .bind(onNext: { [weak self] _ in
                
                UIView.animate(withDuration: 1.0) {
                    
                    self?.view.window?.frame.origin.y -= 300
                }
            })
            .disposed(by: self.disposeBag)
        
        inputCounselorInfoV
            .inputIntroduceField
            .rx
            .didEndEditing
            .bind(onNext: { [weak self] _ in
                    
                self?.view.window?.frame.origin.y += 300
            })
            .disposed(by: self.disposeBag)
        
        inputCounselorInfoV
            .nextButton
            .rx
            .tap
            .bind(onNext: { [weak self] _ in
                
                self?.checkRegisterData()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func checkRegisterData() {
        
        let nilImage = inputCounselorInfoV.profileImageView.image == UIImage(named: AssetImage.myIconFull) || inputCounselorInfoV.profileImageView.image == nil
        let nilName = inputCounselorInfoV.inputNameTextField.text == nil
        let nilAffiliation = inputCounselorInfoV.affiliationTextFieldOne.text == nil
        let nilCertificate = viewModel.output.certificateList.count == 0
        let nilintroduce = inputCounselorInfoV.inputIntroduceField.text == "상세 소개를 작성해주세요"
        let isNoPass = nilImage || nilName || nilAffiliation || nilCertificate || nilintroduce
        
        if isNoPass {
            
            self.showPopUp(popUp: NoPassRegisterPopUp())
        } else {
            
            UserRegisterData.name = getName()
            UserRegisterData.affiliationList = getAffiliationList()
            UserRegisterData.profileImage = getProfileImage()
            UserRegisterData.cerificateImageList = getCertificateImages()
            UserRegisterData.introduce = getIntroduce()
            self.moveSelectCategoryVC()
        }
    }
    
    private func addDidTapScrollViewAction() {
        
        let singleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapScrollView))
        singleTapGestureRecognizer.numberOfTapsRequired = 1
        singleTapGestureRecognizer.isEnabled = true
        singleTapGestureRecognizer.cancelsTouchesInView = false

        inputCounselorInfoV.scrollView.addGestureRecognizer(singleTapGestureRecognizer)
    }
    
    @objc private func didTapScrollView() {
        
        view.endEditing(true)
    }
    
    private func getName() -> String {
        
        return inputCounselorInfoV.inputNameTextField.text!
    }
    
    private func getAffiliationList() -> [String] {
        
        var list: [String] = []
        list.append(inputCounselorInfoV.affiliationTextFieldOne.text!)
        if let two = inputCounselorInfoV.affiliationTextFieldTwo.text {
            
            list.append(two)
        }
        
        if let three = inputCounselorInfoV.affiliationTextFieldThree.text {
            
            list.append(three)
        }
        
        if let four = inputCounselorInfoV.affiliationTextFieldFour.text {
            
            list.append(four)
        }
        
        return list
    }
    
    private func getProfileImage() -> UIImage? {
        
        return inputCounselorInfoV.profileImageView.image
    }
    
    private func getCertificateImages() -> [UIImage?] {
        
        viewModel.output.certificateList.removeFirst()
        
        return viewModel.output.certificateList
    }
    
    private func getIntroduce() -> String {
        
        return inputCounselorInfoV.inputIntroduceField.text
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
        
        if let index = viewModel.output.certificateList.firstIndex(of: image) {
            
            viewModel.output.certificateList.remove(at: index)
            inputCounselorInfoV.inputProfileImageList.reloadData()
        }
    }
}

// MARK: - CollectionView Delegate, DataSource
extension InputCounselorInfoVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        viewModel.output.certificateList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPhotoCell.cellID, for: indexPath) as? AddPhotoCell else {
                
                return UICollectionViewCell()
            }
            
            cell.configureCell(in: viewModel.output.certificateList.count - 1)
            
            return cell
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.cellID, for: indexPath) as? PhotoCell else {
                
                return UICollectionViewCell()
            }
            
            cell.deleteDelegate = self
            let image = viewModel.output.certificateList[indexPath.item]
            cell.configureCell(in: image)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            
            viewModel.isSelectProfile = false
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
            
            if self.viewModel.isSelectProfile {
                
                self.inputCounselorInfoV.profileImageView.contentMode = .scaleToFill
                self.inputCounselorInfoV.profileImageView.image = selectImage
            } else {
                
                self.viewModel.output.certificateList.append(selectImage)
                self.inputCounselorInfoV.inputProfileImageList.reloadData()
            }
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
