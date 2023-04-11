//
//  ChattingListV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import UIKit
import SnapKit
import Then

class ChattingListV: UIView {
    lazy var header: ChattingListHeader = ChattingListHeader()

    private lazy var title: UILabel = UILabel().then {
        $0.text = "채팅"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 14)
    }
    
    lazy var chattingList: UITableView = UITableView().then {
        $0.register(ChattingCell.self, forCellReuseIdentifier: ChattingCell.cellID)
        $0.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        $0.showsVerticalScrollIndicator = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        self.addSubview(header)
        
        self.header.snp.makeConstraints { header in
            header.left.equalTo(self.snp.left)
            header.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            header.right.equalTo(self.snp.right)
        }
        
        self.addSubview(title)
        
        self.title.snp.makeConstraints { title in
            title.left.equalTo(self.snp.left).offset(20)
            title.top.equalTo(self.header.snp.bottom).offset(20)
            title.right.equalTo(self.snp.right).offset(-20)
        }
        
        self.addSubview(chattingList)
        
        self.chattingList.snp.makeConstraints { list in
            list.left.equalTo(self.snp.left)
            list.top.equalTo(self.title.snp.bottom)
            list.right.equalTo(self.snp.right)
            list.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
