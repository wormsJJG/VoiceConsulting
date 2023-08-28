//
//  InputCounselorInfoVM.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/20.
//

import Foundation
import RxSwift

class InputCounselorInfoVM: BaseViewModel {
    
    struct Input {
        
        let isEditInfo: PublishSubject<Void> = PublishSubject()
        let didTapAddAffiliationField: PublishSubject<Void> = PublishSubject()
        let completeEditTrigger: PublishSubject<Void> = PublishSubject()
        var isEdit: Bool = false
    }
    
    struct Output {
        
        var certificateImageList: [UIImage?] = [nil]
        let addAffiliationFieldEvent: PublishSubject<Int> = PublishSubject()
        let counselorData: PublishSubject<Counselor> = PublishSubject()
        var beforeCounselor: Counselor?
        let sucessEditTrigger: PublishSubject<Void> = PublishSubject()
        let errorTrigger: PublishSubject<Error> = PublishSubject()
    }
    
    var input: Input
    var output: Output
    var isSelectProfile: Bool = true
    private var affiliationFieldCount: Int = 1
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(),
         output: Output = Output()) {
        
        self.input = input
        self.output = output
        inputSubscribe()
    }
    
    private func inputSubscribe() {
        
        input.didTapAddAffiliationField
            .bind(onNext: { [weak self] _ in
                
                if self!.affiliationFieldCount < 4 {
                    
                    self?.affiliationFieldCount += 1
                    self?.output
                        .addAffiliationFieldEvent
                        .onNext(self!.affiliationFieldCount)
                }
            })
            .disposed(by: self.disposeBag)
        
        input.isEditInfo
            .subscribe(onNext: { [weak self] _ in
                
                self?.fetchCounselorData()
            })
            .disposed(by: self.disposeBag)
        
        input.completeEditTrigger
            .subscribe(onNext: { [weak self] _ in
                
                self?.editRegisterData()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func fetchCounselorData() {
        
        if let uid = FirebaseAuthManager.shared.getUserUid() {
            
            CounselorManager.shared.getCounselor(in: uid)
                .subscribe({ [weak self] event in
                    
                    switch event {
                        
                    case .next(let counselor):
                        
                        self?.output.beforeCounselor = counselor
                        self?.output.counselorData.onNext(counselor)
                    case .error(let error):
                        
                        self?.output.errorTrigger.onNext(error)
                    case .completed:
                        
                        print("completed")
                    }
                })
                .disposed(by: self.disposeBag)
        }
    }
    
    func convertProfileImageToUrlString(in image: UIImage?,
                                        completion: @escaping((String, Error?) -> Void)) {
        
        FireStorageService.shared.uploadProfileImage(in: image)
            .subscribe({ event in
                
                switch event {
                    
                case .next(let profileUrl):
                    
                    completion(profileUrl, nil)
                case .error(let error):
                    
                    completion("", error)
                case .completed:
                    
                    print("completed")
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    func convertCertificateImageListToUrlStringList(in imageList: [UIImage?],
                                                    completion: @escaping(([String], Error?) -> Void)) {
        
        FireStorageService.shared.uploadCertificateImages(in: imageList)
            .subscribe({ event in
                    
                switch event {
                        
                case .next(let certificateUrlStringList):
                        
                    completion(certificateUrlStringList, nil)
                case .error(let error):
                        
                    completion([], error)
                case .completed:
                        
                    print("completed")
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    func convertUrlStringToUIImage(in urlString: String, image: @escaping(UIImage?) -> Void) {
        
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: URL(string: urlString)!) {
                
               image(UIImage(data: data))
            }
        }
    }
    
    func setAffiliationCount(in count: Int) {
        
        self.affiliationFieldCount = count
    }
    
    private func editRegisterData() {
        
        guard let counselor = output.beforeCounselor else { return }
        
        CounselorManager.shared.editCounselorData(counselor: counselor)
            .subscribe({ [weak self] event in
                
                switch event {
                    
                case .next():
                    
                    self?.output.sucessEditTrigger.onNext(())
                case .error(let error):
                    
                    self?.output.errorTrigger.onNext(error)
                case .completed:
                    
                    print("completed")
                }
            })
            .disposed(by: self.disposeBag)
    }
}
