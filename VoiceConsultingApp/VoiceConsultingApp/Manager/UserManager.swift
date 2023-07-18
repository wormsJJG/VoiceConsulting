//
//  UserManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/06.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import RxSwift

class UserManager {
    static let shared = UserManager()
    private let db = Firestore.firestore().collection(FBCollection.user.rawValue)
    
    // MARK: - checkField
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
    
//    // MARK: - createField
//    func createUserUidField(name: String, uid: String) -> Observable<Void> {
//
//        return Observable.create { event in
//
//            do {
//
//                let user = User(name: name)
//                try self.db.document(uid).setData(from: user, merge: true) { error in
//
//                    if let error {
//
//                        event.onError(error)
//                    } else {
//
//                        event.onNext(())
//                        event.onCompleted()
//                    }
//                }
//                
//            } catch {
//
//                event.onError(error)
//            }
//
//            return Disposables.create()
//        }
//    }
    // MARK: - SelectUserType
    func addUserType(isUser: Bool) -> Observable<Void> {
        return Observable.create { event in
            
            if let uid = FirebaseAuthManager.shared.getUserUid() {
                
                self.db
                    .document(uid).setData([FBUserFields.isUser.rawValue: isUser], merge: true) { error in
                        
                        if let error {
                            
                            event.onError(error)
                        } else {
                            
                            event.onNext(())
                            event.onCompleted()
                        }
                    }
            } else {
                
                event.onError(AuthError.noCurrentUser)
            }
            
            return Disposables.create()
        }
    }
    // MARK: - SelectCategory
    func addCategory(categoryList: [String]) -> Observable<Void> {
        return Observable.create { event in
            
            if let uid = FirebaseAuthManager.shared.getUserUid() {
                
                self.db
                    .document(uid).setData([FBUserFields.categoryList.rawValue: categoryList], merge: true) { error in
                        
                        if let error {
                            
                            event.onError(error)
                        } else {
                            
                            event.onNext(())
                            event.onCompleted()
                        }
                    }
            }
            return Disposables.create()
        }
    }
    // MARK: - createUser
    func createUser(uid: String, user: User) -> Observable<Void> {
        
        Observable.create { event in
            
            do {
                
                try self.db.document(uid)
                    .setData(from: user, merge: true, completion: { error in
                        
                        if let error {
                            
                            event.onError(error)
                        } else {
                            
                            event.onNext(())
                            event.onCompleted()
                        }
                    })
            } catch {
                    
                event.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    // MARK: - getCurrentUserData
    
    func getCurrentUserData() -> Observable<User> {
        
        return Observable.create { event in
            
            if let uid = FirebaseAuthManager.shared.getUserUid() {
                
                let docRef = self.db.document(uid)
                
                docRef.getDocument(as: User.self, completion: { result in
                    
                    switch result {

                    case .success(let user):
                        event.onNext(user)
                        event.onCompleted()
                    case .failure(let error):
                        event.onError(error)
                    }
                })
            } else {
                
                event.onError(AuthError.noCurrentUser)
            }
            return Disposables.create()
        }
    }
}
