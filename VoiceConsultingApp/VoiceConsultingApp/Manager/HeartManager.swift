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
    
    
}
