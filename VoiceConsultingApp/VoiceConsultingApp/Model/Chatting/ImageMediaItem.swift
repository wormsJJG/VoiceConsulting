//
//  ImageMediaItem.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/17.
//

import UIKit
import MessageKit

struct ImageMediaItem: MediaItem {
    
    var url: URL?
    var image: UIImage?
    var placeholderImage: UIImage
    var size: CGSize
    
    init(urlString: String) {
        
        self.url = URL(string: urlString)
        self.size = CGSize(width: 240, height: 240)
        self.placeholderImage = UIImage()
    }
}
