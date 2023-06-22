//
//  BuyCoinHistoryManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import RxSwift

class BuyCoinHistoryManager {
    
    static let shared = BuyCoinHistoryManager()
    private let db = Firestore.firestore().collection(FBCollection.buyCoin.rawValue)
    
    func getBuyHistoryList() -> Observable<[BuyCoinHistory]> {
        
        return Observable.create { event in
            
            if let userUid = FirebaseAuthManager.shared.getUserUid() {
                
                self.db.whereField(BuyCoinField.userId.rawValue, isEqualTo: userUid)
                    .limit(to: 20)
                    .getDocuments() { querySnapshot, error in
                        
                        if let error {
                            
                            event.onError(error)
                        }
                        
                        guard let snapshot = querySnapshot else {
                            
                            event.onError(FBError.nilQuerySnapshot)
                            return
                        }
                        
                        var buyCoinHistoryList: [BuyCoinHistory] = []
                        
                        for document in snapshot.documents {
                            
                            do {
                                
                                let buyCoinHistory = try document.data(as: BuyCoinHistory.self)
                                buyCoinHistoryList.append(buyCoinHistory)
                                
                            } catch {
                                
                                event.onError(error)
                            }
                        }
                        
                        event.onNext(buyCoinHistoryList)
                        event.onCompleted()
                    }
            } else {
                
                event.onError(AuthError.noCurrentUser)
            }
            return Disposables.create()
        }
    }
}
