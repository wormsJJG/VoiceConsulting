//
//  SettlementManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/13.
//

import Foundation
import RxSwift
import FirebaseFirestore
import FirebaseFirestoreSwift


class SettlementManager {
    
    static let shared = SettlementManager()
    private let db = Firestore.firestore().collection(FBCollection.settlement.rawValue)
    
    func fetchSettlementHistory() -> Observable<[SettlementDetail]> {
        
        return Observable.create { event in
            
            if let currentUserUid = FirebaseAuthManager.shared.getUserUid() {
             
                self.db
                    .whereField(SettlementField.counselorUid.rawValue,
                                isEqualTo: currentUserUid)
                    .getDocuments(completion: { querySnapshot, error in
                        
                        if let error {
                            
                            event.onError(error)
                        }
                        
                        if let querySnapshot {
                            
                            var settlementDetailList: [SettlementDetail] = []
                            for document in querySnapshot.documents {
                                
                                do {
                                    
                                    let settlementDetail = try document.data(as: SettlementDetail.self)
                                    settlementDetailList.append(settlementDetail)
                                } catch {
                                    
                                    event.onError(error)
                                }
                            }
                            
                            event.onNext(settlementDetailList)
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
    
    func addSettlementDetail(in settlementDetail: SettlementDetail, completion: @escaping((Error?) -> Void)) {
        
        do {
            
            try self.db.addDocument(from: settlementDetail) { error in
                
                if let error {
                    
                    completion(error)
                } else {
                    
                    completion(nil)
                }
            }
        } catch {
            
            completion(error)
        }
    }
}
