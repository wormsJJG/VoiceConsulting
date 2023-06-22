//
//  Extension+Rx+ScrollView.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/06/19.
//

import Foundation

import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {
  func reachedBottom(from space: CGFloat = 0.0) -> ControlEvent<Void> { //스크롤이 아래쪽에 닿았을 때를 감지하는 함수 2022-12-22
    let source = contentOffset.map { contentOffset in
      let visibleHeight = self.base.frame.height - self.base.contentInset.top - self.base.contentInset.bottom
      let y = contentOffset.y + self.base.contentInset.top
      let threshold = self.base.contentSize.height - visibleHeight - space
      return y >= threshold
    }
    .distinctUntilChanged()
    .filter { $0 }
    .map { _ in () }
    return ControlEvent(events: source)
  }
}

