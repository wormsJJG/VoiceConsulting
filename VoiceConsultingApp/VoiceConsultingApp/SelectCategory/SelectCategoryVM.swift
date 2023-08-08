//
//  SelectCategoryVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/30.
//

import Foundation
import RxSwift
import RxCocoa

class SelectCategoryVM: BaseViewModel {
    
    struct Input {
        var userSelectCategoryList: [String] = []
        var didTapCompleteButton: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        let categoryList: PublishSubject<[CategoryType]> = PublishSubject()
        let completion: PublishSubject<Error?> = PublishSubject()
    }
    
    var input: Input
    var output: Output
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(),
         output: Output = Output()) {
        self.input = input
        self.output = output
        inputSubscribe()
        getCategoryList()
    }
    
    private func inputSubscribe() {
        self.input.didTapCompleteButton
            .filter { !self.input.userSelectCategoryList.isEmpty }
            .bind(onNext: { [weak self] _ in
                
                self?.register()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func getCategoryList() {
        
        CategoryManager.shared.getCategoryList()
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let categoryList):
                    
                    self?.output.categoryList.onNext(categoryList)
                case .error(let error):
                    
                    print(error)
                case .completed:
                    
                    print("onCompleted")
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func register() {
        
        if UserRegisterData.isUser {
            
            registerUser()
        } else {
            
            registerCounselor()
        }
    }
    
    private func registerUser() {
        
    }
    
    private func uploadImageForCounselor(completion: @escaping(String, [String], Error?) -> Void) {
        
        FireStorageService.shared.uploadProfileImage(in: UserRegisterData.profileImage)
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next(let profileUrl):
                    
                    FireStorageService.shared.uploadCertificateImages(in: UserRegisterData.cerificateImageList)
                        .subscribe({ event in
                            
                            switch event {
                                
                            case .next(let certificateUrlList):
                                
                                completion(profileUrl, certificateUrlList, nil)
                            case .error(let error):
                                
                                completion("", [], error)
                            case .completed:
                                
                                print("completed")
                            }
                        })
                        .disposed(by: self!.disposeBag)
                case .error(let error):
                    
                    completion("", [], error)
                case .completed:
                    
                    print("completed")
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func registerCounselor() {
        
        if let uid = FirebaseAuthManager.shared.getUserUid() {
            
            uploadImageForCounselor(completion: { [weak self] profileImageUrl, licenseImages, error in
                
                if let error {
                    
                    self?.output.completion.onNext(error)
                } else {
                    
                    let counselor = CounselorInfo(name: UserRegisterData.name,
                                                  categoryList: self!.input.userSelectCategoryList,
                                                  affiliationList: UserRegisterData.affiliationList,
                                                  licenseImages: licenseImages,
                                                  profileImageUrl: profileImageUrl,
                                                  introduction: UserRegisterData.introduce,
                                                  phoneNumber: nil)
                    
                    CounselorManager.shared.registerCounselor(uid: uid, counselor: counselor)
                        .subscribe({ [weak self] event in
                            
                            switch event {
                                
                            case .next(_):
                                
                                Config.isUser = UserRegisterData.isUser
                                Config.name = UserRegisterData.name
                                Config.profileUrlString = profileImageUrl
                                self?.output.completion.onNext(nil)
                            case .error(let error):
                                
                                self?.output.completion.onNext(error)
                            case .completed:
                                
                                print("completed")
                            }
                        })
                        .disposed(by: self!.disposeBag)
                }
            })
        }
    }
    
    private func addCategoryList() {
        
        if let uid = FirebaseAuthManager.shared.getUserUid() {
            
//            let user = User(name: UserRegisterData.name ?? "name",
//                            categoryList: input.userSelectCategoryList,
//                            fcmToken: "",
//                            profileImageUrl: UserRegisterData.profileUrl ?? "")
//
//            UserManager.shared.createUser(uid: uid, user: user)
//                .subscribe({ [weak self] event in
//
//                    switch event {
//
//                    case .next(_):
//
//                        Config.isUser = true
//                        Config.name = UserRegisterData.name ?? "name"
//                        Config.profileUrlString = UserRegisterData.profileUrl
//                        self?.output.completion.onNext(nil)
//                    case .error(let error):
//
//                        self?.output.completion.onNext(error)
//                    case .completed:
//
//                        print("onCompleted")
//                    }
//                })
//                .disposed(by: self.disposeBag)
        }
    }
    
    func checkedCategory(in modelId: String) -> Bool {
        
        for selectId in input.userSelectCategoryList {
            
            if selectId == modelId {
                
                return true
            }
        }
        
        return false
    }
}
