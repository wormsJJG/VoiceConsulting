//
//  ReportManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/09/05.
//

import Foundation
import FirebaseFirestore

class ReportManager {
    
    static let shared = ReportManager()
    private let db = Firestore.firestore().collection(FBCollection.report.rawValue)
    
    func report(reporter: String, target: String, completion: @escaping((Error?) -> Void)) {
        
        let report = Report(reporter: reporter, targetId: target)
        
        do {
            
            try self.db.addDocument(from: report) { error in
                
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
