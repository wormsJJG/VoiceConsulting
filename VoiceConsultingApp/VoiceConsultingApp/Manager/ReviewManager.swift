//
//  ReviewManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/26.
//

import Foundation
import RxSwift
import FirebaseFirestore
import FirebaseFirestoreSwift

class ReviewManager {
    
    static let shared = ReviewManager()
    private let db = Firestore.firestore().collection(FBCollection.review.rawValue)
    
    func getReviewList(in counselorId: String) -> Observable<ReviewList> {
        
        return Observable.create { event in
            
            self.db
                .whereField(ReviewField.counselorId.rawValue, isEqualTo: counselorId)
                .getDocuments() { querySnapshot, error in
                    if let error {
                        
                        event.onError(error)
                    }
                    
                    guard let snapshot = querySnapshot else {
                        
                        event.onError(FBError.nilSnapshot)
                        return
                    }
                    
                    var reviewList: ReviewList = []
                    
                    for document in snapshot.documents {
                        
                        do {
                            
                            let review = try document.data(as: Review.self)
                            reviewList.append(review)
                        } catch {
                            
                            event.onError(error)
                        }
                    }
                    
                    event.onNext(reviewList)
                    event.onCompleted()
                }
            return Disposables.create()
        }
    }
}
