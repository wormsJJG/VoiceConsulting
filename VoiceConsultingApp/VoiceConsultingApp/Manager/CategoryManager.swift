//
//  CategoryManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/15.
//

import Foundation
import RxSwift
import FirebaseFirestore
import FirebaseFirestoreSwift

class CategoryManager {
    
    static let shared = CategoryManager()
    private let db = Firestore.firestore()
    
    func getCategoryList() -> Observable<[Category]> {

        return Observable.create { event in
            
            self.db.collection(FBCollection.category)
                .getDocuments() { querySnapshot, error in
                    if let error = error {
                        
                        event.onError(error)
                    }
                    
                    guard let snapshot = querySnapshot else {
                        
                        event.onError(FBError.nilQuerySnapshot)
                        return
                    }
                    
                    var categoryList: [Category] = []
                    
                    for document in snapshot.documents {
                        
                        do {
                            
                            let category = try document.data(as: Category.self)
                            categoryList.append(category)
                        } catch {
                            
                            event.onError(error)
                        }
                    }
                    event.onNext(categoryList)
                    event.onCompleted()
                }
            return Disposable.create()
        }
    }
}
