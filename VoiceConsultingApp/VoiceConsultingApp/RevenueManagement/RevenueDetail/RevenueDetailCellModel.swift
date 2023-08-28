//
//  RevenueDetailCellModel.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/13.
//

import Foundation

struct RevenueDetailCellModel {
    
    var userName: String
    var userProfileUrlString: String?
    var consultingDetail: Consulting
    
    func convertCreateAtToString() -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(consultingDetail.createAt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        let formattedDate = dateFormatter.string(from: date)
        
        return formattedDate
    }
    
    func convertCoinCountToString() -> String {
        
        return "코인 100개"
    }
    
    func convertConsultingTimeToString() -> String {
        
        return "상담시간 \(consultingDetail.duration):00"
    }
}
