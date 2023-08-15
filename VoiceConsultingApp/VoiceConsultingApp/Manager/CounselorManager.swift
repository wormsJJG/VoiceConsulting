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
    
    private var onlineLastSnapShot: QueryDocumentSnapshot?
    private var popularLastSnapShot: QueryDocumentSnapshot?
    private var fitWellLastSnapShot: QueryDocumentSnapshot?
    
    private let disposeBag = DisposeBag()
    // MARK: - init 접근 제어
    private init() {
        
    }
    
    // MARK: - 필드 확인
    func checkField(uid: String) -> Observable<Bool> {
        return Observable.create { event in
            
            self.db.document(uid).getDocument(completion: { documentSnapshot, error in
                
                if let error {
                    
                    event.onError(error)
                }
                
                if let snapshot = documentSnapshot {
                    
                    event.onNext(snapshot.exists)
                    event.onCompleted()
                } else {
                    
                    event.onError(FBError.nilSnapshot)
                }
            })
            
            return Disposables.create()
        }
    }
    
    // MARK: - 상담사 가입
    func registerCounselor(uid: String, counselor: CounselorInfo) -> Observable<Void> {
        Observable.create { event in
            
            do {
                
                try self.db.document(uid).setData(from: counselor, merge: true) { error in
                    
                    if let error {
                        
                        event.onError(error)
                    }
                    
                    event.onNext(())
                    event.onCompleted()
                }
            } catch {
                
                event.onError(error)
            }
            
            return Disposables.create()
        }
    }
    // MARK: - 상담사 정보 수정
    func editCounselorData(counselor: Counselor) -> Observable<Void> {
        
        Observable.create { event in
            
            do {
                
                try self.db.document(counselor.uid).setData(from: counselor.info, merge: true) { error in
                    
                    if let error {
                        
                        event.onError(error)
                    }
                    
                    event.onNext(())
                    event.onCompleted()
                }
            } catch {
                
                event.onError(error)
            }
            
            return Disposables.create()
        }
    }
    // MARK: - getOnlineCounselor
    func getOnlineCounselorList(with limit: Int) -> Observable<[Counselor]> {
        Observable.create { event in
            self.db
                .whereField(CounselorField.isHidden.rawValue, isEqualTo: false)
                .whereField(CounselorField.isOnline.rawValue, isEqualTo: true)
                .limit(to: limit)
                .getDocuments { querySnapshot, error in
                    
                    if let error {
                        event.onError(error)
                    }
                    
                    guard let snapshot = querySnapshot else {
                        event.onError(FBError.nilSnapshot)
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
    // MARK: - getPopularCounselor
    func getPopularCounselorList(with limit: Int) -> Observable<[Counselor]> {
        Observable.create { event in
            self.db
                .order(by: CounselorField.heartCount.rawValue, descending: true)
                .limit(to: limit)
                .getDocuments() { querySnapshot, error in
                    if let error {
                        event.onError(error)
                    }
                    
                    guard let snapshot = querySnapshot else {
                        event.onError(FBError.nilSnapshot)
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
    // MARK: - getFitWellCounselor
    func getFitWellCounselorList(with limit: Int) -> Observable<[Counselor]> {
        
        return Observable.create { event in
            self.db
                .whereField(CounselorField.isOnline.rawValue, isEqualTo: false)
                .limit(to: limit)
                .getDocuments() { querySnapshot, error in
                    
                    if let error {
                        
                        event.onError(error)
                    }
                    
                    guard let snapshot = querySnapshot else {
                        
                        event.onError(FBError.nilSnapshot)
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
    // MARK: - getCounselor
    func getCounselor(in uid: String) -> Observable<Counselor> {
        
        return Observable.create { event in
            
            let ref = self.db.document(uid)
            ref.getDocument(as: CounselorInfo.self, completion: { result in
                
                switch result {
                    
                case .success(let counselorInfo):
                    
                    let counselor = Counselor(uid: uid, info: counselorInfo)
                    event.onNext(counselor)
                    event.onCompleted()
                case .failure(let error):
                    
                    event.onError(error)
                }
            })
            return Disposables.create()
        }
    }
    // MARK: -
    func convertUidToCounselor(in uidList: [String]) -> Observable<[Counselor]> {
        
        return Observable.create { event in
            
            var counselorList: [Counselor] = []
            
            for uid in uidList {
                
                self.db.document(uid)
                    .getDocument(as: CounselorInfo.self, completion: { result in
                        
                        switch result {
    
                        case .success(let counselorInfo):
                            
                            let counselor = Counselor(uid: uid, info: counselorInfo)
                            counselorList.append(counselor)
                        case .failure(let error):
                            
                            event.onError(error)
                        }
                    })
            }
            event.onNext(counselorList)
            event.onCompleted()
            
            return Disposables.create()
        }
    }
    
    func increaseHeart(in counselorUid: String) {
        
        db.document(counselorUid).updateData([CounselorField.heartCount.rawValue: FieldValue.increment(Int64(1))])
    }
    
    func decreaseHeart(in counselorUid: String) {
        
        db.document(counselorUid).updateData([CounselorField.heartCount.rawValue: FieldValue.increment(Int64(-1))])
    }
    
    func subCoin(in coinCount: Int, completion: @escaping((Error?) -> Void)) {
        
        if let uid = FirebaseAuthManager.shared.getUserUid() {
            
            db.document(uid).updateData([CounselorField.coin.rawValue: FieldValue.increment(Int64(-coinCount))]) { error in
                
                completion(error)
            }
        } else {
            
            completion(AuthError.noCurrentUser)
        }
    }
    
    func addCoin(in coinCount: Int, completion: @escaping((Error?) -> Void)) {
        
        if let uid = FirebaseAuthManager.shared.getUserUid() {
            
            db.document(uid).updateData([CounselorField.coin.rawValue: FieldValue.increment(Int64(coinCount))]) { error in
                
                completion(error)
            }
        } else {
            
            completion(AuthError.noCurrentUser)
        }
    }
    
    func changeIsOnline(in isOnline: Bool, completion: @escaping((Error?) -> Void)) {
        
        if let uid = FirebaseAuthManager.shared.getUserUid() {
            
            db.document(uid).updateData([CounselorField.isOnline.rawValue: isOnline]) { error in
                
                completion(error)
            }
        } else {
            
            completion(AuthError.noCurrentUser)
        }
    }
    // MARK: - TestFunc
//    func createMockData() {
//        
//        for i in 1...10 {
//            
//            var counselor = CounselorInfo(name: "정이름\(i)", categoryList: ["0", "3", "2", "1"], affiliationList: ["소속기관\(i)", "회사\(i)", "협회\(i)"], licenseImages: ["https://firebasestorage.googleapis.com/v0/b/voiceconsultingapp.appspot.com/o/uuwwn6u0xrhs4arnrhuolg3kkaj1%2Fintroduce%2F2desktop-wallpaper-new-cb-backgrounds-2018-picsart-cb-backgrounds-pic-background.jpg.jpg?alt=media&token=5c0f045d-ebc4-4001-a21f-c6e260d4a764", "https://firebasestorage.googleapis.com/v0/b/voiceconsultingapp.appspot.com/o/uuwwn6u0xrhs4arnrhuolg3kkaj1%2Fintroduce%2F3desktop-wallpaper-new-cb-backgrounds-2020-cb-background.jpg.jpg?alt=media&token=0247a1d1-b48a-4427-8297-d25430018f66", "https://firebasestorage.googleapis.com/v0/b/voiceconsultingapp.appspot.com/o/uuwwn6u0xrhs4arnrhuolg3kkaj1%2Fintroduce%2F4desktop-wallpaper-q-beautiful-beautiful-village-gallery-nature-background-nature-nature.jpg.jpg?alt=media&token=40fd7ce6-9218-4a69-858b-2db4d0955427"], profileImageUrl: "https://firebasestorage.googleapis.com/v0/b/levelup-release-e1bce.appspot.com/o/UserProfileImages%2Fx4P1KbvTMdbnnFkXnwehyB8PO792?alt=media&token=1b7bf2fd-d572-4797-ab48-f47f15eaf34a", introduction: "안녕하세요 저는 정이름\(i) 상담사입니다.\n언제든 상담문의 주세요.\n 열심히 해드리겠습니다.\n안녕하세요 저는 정이름\(i) 상담사입니다.\n언제든 상담문의 주세요.\n 열심히 해드리겠습니다.\n안녕하세요 저는 정이름\(i) 상담사입니다.\n언제든 상담문의 주세요.\n 열심히 해드리겠습니다.\n안녕하세요 저는 정이름\(i) 상담사입니다.\n언제든 상담문의 주세요.\n 열심히 해드리겠습니다.", phoneNumber: "010-1234-1234")
//            counselor.isHidden = false
//            counselor.isOnline = true
//            registerCounselor(counselor: counselor)
//                .subscribe(onNext: { documentId in
//                    print(documentId)
//                }, onError: { error in
//                    print(error.localizedDescription)
//                })
//                .disposed(by: self.disposeBag)
//        }
//    }
}
