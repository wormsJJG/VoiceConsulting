//
//  Extension+UISCrollView.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/07.
//

import UIKit

public enum ScrollDirection {
    case top
    case center
    case bottom
}

extension UIScrollView {
    func scroll(to direction: ScrollDirection) {

            DispatchQueue.main.async {
                switch direction {
                case .top:
                    self.scrollToTop()
                case .center:
                    self.scrollToCenter()
                case .bottom:
                    self.scrollToBottom()
                }
            }
        }

        private func scrollToTop() {
            setContentOffset(.zero, animated: true)
        }

        private func scrollToCenter() {
            let centerOffset = CGPoint(x: 0, y: (contentSize.height - bounds.size.height) / 2)
            setContentOffset(centerOffset, animated: true)
        }

        private func scrollToBottom() {
            let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
            if(bottomOffset.y > 0) {
                setContentOffset(bottomOffset, animated: true)
            }
        }
}
