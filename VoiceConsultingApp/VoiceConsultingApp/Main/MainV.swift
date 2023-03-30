//
//  MainV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/26.
//

import UIKit
import Then
import SnapKit

class MainV: UIView {
    
    lazy var mainList: UITableView = UITableView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    private func constraint() {
        self.addSubview(mainList)
        
        self.mainList.snp.makeConstraints { list in
            list.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            list.left.equalTo(self.snp.left)
            list.right.equalTo(self.snp.right)
            list.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
