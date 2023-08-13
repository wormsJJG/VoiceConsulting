//
//  RealmManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/04.
//

import Foundation
import Realm
import RealmSwift

class RealmService {
    static let shared = RealmService()
    
    private var realm: Realm!
    
    init() {
        
        self.realm = try! Realm()
    }
    
    func addObject(in object: Object, completion: @escaping(Error?) -> Void) {
        
        do {
            
            try realm.write {
                    
                realm.add(object)
            }
        } catch {
            
            completion(error)
        }
    }
    
    func fetchObject<Element: RealmFetchable>(in objectType: Element, completion: @escaping(Results<Element>) -> Void) {
        
        let objects = realm.objects(Element.self)
        
        completion(objects)
    }
}
