//
//  Extension+String.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/09.
//

import Foundation

extension String {
  var asBase64: String? {
    let utf8Data = self.data(using: .utf8)
    return utf8Data?.base64EncodedString()
  }
}
