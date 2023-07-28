//
//  FavouriteManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/29.
//

import Foundation
import RxSwift
import FirebaseFirestore
import FirebaseFirestoreSwift

class FavouriteManager {
    
    static let shared = FavouriteManager()
    private let db = Firestore.firestore().collection(FBCollection.favourite.rawValue)
    
    func getFavouriteList() -> Observable<FavouriteList> {
        
        return Observable.create { event in
            
            if let userUid = FirebaseAuthManager.shared.getUserUid() {
                
                self.db
                    .whereField(FavouriteField.userId.rawValue, isEqualTo: userUid)
                    .getDocuments() { querySnapshot, error in
                        
                        if let error {
                            
                            event.onError(error)
                        }
                        
                        guard let snapshot = querySnapshot else {
                            
                            event.onError(FBError.nilSnapshot)
                            return
                        }
                        
                        var favouriteList: FavouriteList = []
                        
                        for document in snapshot.documents {
                            
                            do {
                                
                                let favourite = try document.data(as: Favourite.self)
                                favouriteList.append(favourite)
                            } catch {
                                
                                event.onError(error)
                            }
                        }
                        
                        event.onNext(favouriteList)
                        event.onCompleted()
                    }
            } else {
                
                event.onError(AuthError.noCurrentUser)
            }
            
            return Disposables.create()
        }
    }
    
    func addFavouriteCounselor(isHeart: Bool, counselorUid: String) -> Observable<Bool> {

        return Observable.create { event in
            
            if let userUid = FirebaseAuthManager.shared.getUserUid() {
                
                if isHeart {
                        
                    let favouriteModel = Favourite(counselorId: counselorUid, userId: userUid)
                        do {
                            
                            try self.db.addDocument(from: favouriteModel) { error in
                                
                                if let error {
                                    
                                    event.onError(error)
                                } else {
                                    
                                    event.onNext(true)
                                    event.onCompleted()
                                }
                            }
                        } catch {
                            
                            event.onError(error)
                        }
                } else {
                    
                    self.db
                        .whereField(FavouriteField.userId.rawValue, isEqualTo: userUid)
                        .whereField(FavouriteField.counselorId.rawValue, isEqualTo: counselorUid)
                        .getDocuments(completion: { querySnapshot, error in
                            
                            if let error {
                                
                                event.onError(error)
                            }
                            
                            if let snapshot = querySnapshot {
                                
                                if let document = snapshot.documents.first {
                                    
                                    self.db.document(document.documentID).delete() { error in
                                        
                                        if let error {
                                            
                                            event.onError(error)
                                        }
                                        event.onNext(false)
                                        event.onCompleted()
                                    }
                                }
                                
                            } else {
                                
                                event.onError(FBError.nilSnapshot)
                            }
                        })
                }
            } else {
                
                event.onError(AuthError.noCurrentUser)
            }
            return Disposables.create()
        }
    }
    
    func checkIsFavorite(in counselorUid: String) -> Observable<Bool> {
        
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
