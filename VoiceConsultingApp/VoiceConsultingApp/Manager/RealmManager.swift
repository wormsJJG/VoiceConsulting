//
//  RealmManager.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/04.
//

import Foundation
import Realm
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    
    var realm: Realm!
    
    init() {
        self.realm = try! Realm()
    }
    
    
}
