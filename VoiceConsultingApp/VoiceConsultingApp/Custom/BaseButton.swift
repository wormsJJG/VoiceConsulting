//
//  BaseButton.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/22.
//

import UIKit

class BaseButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)

        /// 모든 방향에 20만큼 터치 영역 증가
        /// dx: x축이 dx만큼 증가 (음수여야 증가)
        let touchArea = bounds.insetBy(dx: -20, dy: -20)
        return touchArea.contains(point)
    }
}
