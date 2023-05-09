//
//  CounselorManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/06.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import RxSwift

class CounselorManager {
    static let shared = CounselorManager()
    private let db = Firestore.firestore().collection(FBCollection.counselor.rawValue)
    
    private let disposeBag = DisposeBag()
    // MARK: - init 접근 제어
    private init() {
        
    }
    
    // MARK: - 상담사 가입
    func registerCounselor(counselor: CounselorInfo) -> Observable<String> {
        Observable.create { event in
            var ref: DocumentReference? = nil
                
            do {
                ref = try self.db.addDocument(from: counselor) { error in
                    if let error {
                        event.onError(error)
                    } else {
                        event.onNext(ref!.documentID)
                        event.onCompleted()
                    }
                }
            } catch {
                event.onError(error)
            }
            return Disposables.create()
        }
    }
    
    // MARK: - getOnlineCounselor
    func getOnlineCounselorList() -> Observable<[Counselor]> {
        Observable.create { event in
            self.db
                .whereField(CounselorField.isHidden.rawValue, isEqualTo: false)
                .whereField(CounselorField.isOnline.rawValue, isEqualTo: true)
                .getDocuments { querySnapshot, error in
                    if let error {
                        event.onError(error)
                    }
                    
                    guard let snapshot = querySnapshot else {
                        event.onError(FBError.nilQuerySnapshot)
                        return
                    }
                    
                    var counselorList: [Counselor] = []
                    
                    for document in snapshot.documents {
                        do {
                            let counselorInfo = try document.data(as: CounselorInfo.self)
                            let counselor = Counselor(uid: document.documentID, info: counselorInfo)
                            counselorList.append(counselor)
                        } catch {
                            event.onError(error)
                        }
                    }
                    event.onNext(counselorList)
                    event.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    // MARK: - TestFunc
    func createMockData() {
        for i in 1...10 {
            var counselor = CounselorInfo(name: "성이름\(i) 상담사",
                                      category: ["부부상담", "아동상담", "외도상담", "성인상담", "기타상담"],
                                      company: ["소속기관\(i)", "회사\(i)", "협회\(i)"],
                                      progileImage: "https://firebasestorage.googleapis.com/v0/b/levelup-release-e1bce.appspot.com/o/UserProfileImages%2Fx4P1KbvTMdbnnFkXnwehyB8PO792?alt=media&token=1b7bf2fd-d572-4797-ab48-f47f15eaf34a",
                                      introduction: "안녕하세요 저는 성이름\(i) 상담사입니다.\n언제든 상담문의 주세요.\n 열심히 해드리겠습니다.",
                                      phoneNumber: "010-1234-1234",
                                      coverImages: ["", "", ""])
            counselor.isHidden = false
            registerCounselor(counselor: counselor)
                .subscribe(onNext: { documentId in
                    print(documentId)
                }, onError: { error in
                    print(error.localizedDescription)
                })
                .disposed(by: self.disposeBag)
        }
    }
}
