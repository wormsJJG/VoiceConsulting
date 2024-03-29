//
//  ConsultingHistoryManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/28.
//

import Foundation
import RxSwift
import FirebaseFirestore
import FirebaseFirestoreSwift

class ConsultingHistoryManager {
    
    static let shared = ConsultingHistoryManager()
    private let db = Firestore.firestore()
        .collection(FBCollection.consulting.rawValue)
    
    func getConsultingHistoryList() -> Observable<ConsultingList> {
        
        return Observable.create { event in
            
            if let userUid = FirebaseAuthManager.shared.getUserUid() {
                
                self.db
                    .whereField(ConsultingField.userId.rawValue,
                                isEqualTo: userUid)
                    .getDocuments() { querySnapshot, error in
                        
                        if let error {
                            
                            event.onError(error)
                        }
                        
                        guard let snapshot = querySnapshot else {
                            
                            event.onError(FBError.nilSnapshot)
                            return
                        }
                        
                        var historyList: ConsultingList = []
                        
                        for document in snapshot.documents {
                            
                            do {
                                
                                let consultingHistory = try document.data(as: Consulting.self)
                                historyList.append(consultingHistory)
                            } catch {
                                
                                event.onError(error)
                            }
                        }
                     
                        event.onNext(historyList)
                        event.onCompleted()
                    }
            } else {
                
                event.onError(AuthError.noCurrentUser)
            }
            return Disposables.create()
        }
    }
    
    func getConsultingHistoryForCounselor() -> Observable<ConsultingList> {
        
        return Observable.create { event in
            
            if let userUid = FirebaseAuthManager.shared.getUserUid() {
                
                self.db
                    .whereField(ConsultingField.counselorId.rawValue,
                                isEqualTo: userUid)
                    .getDocuments() { querySnapshot, error in
                        
                        if let error {
                            
                            event.onError(error)
                        }
                        
                        guard let snapshot = querySnapshot else {
                            
                            event.onError(FBError.nilSnapshot)
                            return
                        }
                        
                        var historyList: ConsultingList = []
                        
                        for document in snapshot.documents {
                            
                            do {
                                
                                let consultingHistory = try document.data(as: Consulting.self)
                                historyList.append(consultingHistory)
                            } catch {
                                
                                event.onError(error)
                            }
                        }
                     
                        event.onNext(historyList)
                        event.onCompleted()
                    }
            } else {
                
                event.onError(AuthError.noCurrentUser)
            }
            return Disposables.create()
        }
    }
    
    func writeConsultingHistory(userId: String, counselorId: String, completion: @escaping((Error?) -> Void)) {
    
        let consulting = Consulting(userId: userId,
                                    counselorId: counselorId)
        
        do {
            
            try self.db.addDocument(from: consulting) { error in
                
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
