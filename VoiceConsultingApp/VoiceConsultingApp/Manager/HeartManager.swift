//
//  HeartManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/26.
//

import Foundation
import RxSwift
import FirebaseFirestore
import FirebaseFirestoreSwift

class HeartManager {
    
    static let shared = HeartManager()
    private let db = Firestore.firestore().collection(FBCollection.favourite.rawValue)
    
    func heart(isHeart: Bool, counselorUid: String) -> Observable<Bool> {

        return Observable.create { event in
            
            if isHeart {
                
                self.db.addDo
            }
            return Disposables.create()
        }
    }
    
    func checkIsHeart(in counselorUid: String) -> Observable<Bool> {
        
        return Observable.create { event in
            if let userUid = FirebaseAuthManager.shared.getUserUid() {
                
                self.db
                    .whereField(FavouriteField.userId.rawValue, isEqualTo: userUid)
                    .whereField(FavouriteField.counselorId.rawValue, isEqualTo: counselorUid)
                    .getDocuments(completion: { querySnapshot, error in
                        
                        if let error {
                            
                            event.onError(error)
                        }
                        
                        if let snapshot = querySnapshot {
                            
                            if snapshot.documents.count > 0 {
                                
                                event.onNext(true)
                            } else {
                                
                                event.onNext(false)
                            }
                            
                            event.onCompleted()
                        } else {
                            
                            event.onError(FBError.nilSnapshot)
                        }
                    })
            } else {
                
                event.onError(AuthError.noCurrentUser)
            }
            return Disposables.create()
        }
    }
}
