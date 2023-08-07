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
    
    var categoryList: CategoryList?
    static let shared = CategoryManager()
    private let db = Firestore.firestore().collection(FBCollection.category.rawValue)
    
    private init() {}
    
    func initCategoryData() {
        
        self.db
            .order(by: CategoryField.modelId.rawValue, descending: false)
            .getDocuments() { querySnapshot, error in
                
                guard let snapshot = querySnapshot else {
                    
                    return
                }
                
                var categoryList: [CategoryType] = []
                
                for document in snapshot.documents {
                    
                    do {
                        
                        let category = try document.data(as: CategoryType.self)
                        categoryList.append(category)
                    } catch {
                        
                        print(error.localizedDescription)
                    }
                }
                
                self.categoryList = categoryList
            }
    }
    
    func getCategoryList() -> Observable<[CategoryType]> {

        return Observable.create { event in
            
            self.db
                .order(by: CategoryField.modelId.rawValue, descending: false)
                .getDocuments() { querySnapshot, error in
                    if let error = error {
                        
                        event.onError(error)
                    }
                    
                    guard let snapshot = querySnapshot else {
                        
                        event.onError(FBError.nilSnapshot)
                        return
                    }
                    
                    var categoryList: [CategoryType] = []
                    
                    for document in snapshot.documents {
                        
                        do {
                            
                            let category = try document.data(as: CategoryType.self)
                            categoryList.append(category)
                        } catch {
                            
                            event.onError(error)
                        }
                    }
                    
                    event.onNext(categoryList)
                    event.onCompleted()
                }
            return Disposables.create()
        }
    }
    
    func convertToCategoryName(in categoryId: String) -> Observable<String> {
        
        return Observable.create { event in
            
            self.db
                .document(categoryId)
                .getDocument(as: CategoryType.self) { result in
                    
                    switch result {
                        
                    case .success(let category):
                        event.onNext(category.categoryNameKr)
                        event.onCompleted()
                    case .failure(let error):
                        event.onError(error)
                    }
                }
                        
            return Disposables.create()
        }
    }
    
    func convertIdToName(in id: String) -> String {
        
        guard let categoryList = self.categoryList else {
            
            return "noData"
        }
        
        guard let category = categoryList.filter({ $0.modelId == id }).first else {
            
            return "noData"
        }
        
        return category.categoryNameKr
    }
}
