//
//  CheckDataManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/17.
//

import Foundation
import RealmSwift

class CheckDataManager {
    
    static let shared = CheckDataManager()
    private let database: Realm
    
    private init() {
        self.database = try! Realm()
    }
    
    func setIsUser(isUser: Bool, completion: @escaping (Error?) -> Void) {
        
        let checkData = CheckData()
        checkData.isUser = isUser
        
        do {
            
            try database.write {
                    
                database.add(checkData)
                completion(nil)
            }
        } catch {
            
            completion(error)
        }
    }
    
    func getCheckData(completion: @escaping (CheckData?, Error?) -> Void) {
        
        do {
            
            let checkData = database.objects(CheckData.self)
            
            completion(checkData.first, nil)
        } catch {
            
            completion(nil, error)
        }
    }
}
