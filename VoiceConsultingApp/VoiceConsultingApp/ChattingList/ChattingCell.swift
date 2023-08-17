//
//  ChattingCellTableViewCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import UIKit
import Then
import SnapKit
import Kingfisher

class ChattingCell: UITableViewCell {
    
    static let cellID = "ChattingCell"
    private let emptyContentText = "주고 받은 메세지가 없습니다.\n메세지를 보내보세요."
    
    lazy var thumnailImage: UIImageView = UIImageView().then {
        
        $0.image = UIImage(named: AssetImage.thumnail)
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.backgroundColor = .gray
    }
    
    lazy var name: UILabel = UILabel().then {
        
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.text = "김이름 상담사"
        $0.textColor = ColorSet.mainText
    }
    
    lazy var content: UILabel = UILabel().then {
        
        $0.textColor = ColorSet.subTextColor
        $0.text = "내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 12)
        $0.numberOfLines = 2
    }
    
    lazy var date: UILabel = UILabel().then {
        
        $0.textColor = ColorSet.date
        $0.text = "2023.04.11"
        $0.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 12)
        $0.numberOfLines = 1
    }
    
    lazy var nameAndDate: UIStackView = UIStackView(arrangedSubviews: [name, date]).then {
        
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    
    lazy var rightStack: UIStackView = UIStackView(arrangedSubviews: [nameAndDate, content]).then {
        
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .leading
    }
    
    lazy var allStack: UIStackView = UIStackView(arrangedSubviews: [thumnailImage, rightStack]).then {
        
        $0.axis = .horizontal
        $0.spacing = 10
        $0.alignment = .top
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        constraint()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        
        self.thumnailImage.snp.makeConstraints { image in
            image.width.height.equalTo(50)
        }
        
        self.contentView.addSubview(allStack)
        
        self.allStack.snp.makeConstraints { sv in
            sv.left.equalTo(self.contentView.snp.left).offset(20)
            sv.top.equalTo(self.contentView.snp.top).offset(20)
            sv.right.equalTo(self.contentView.snp.right).offset(-20)
            sv.bottom.equalTo(self.contentView.snp.bottom).offset(-20)

        }
        
        self.nameAndDate.snp.makeConstraints { sv in
            sv.right.equalTo(self.rightStack.snp.right)
        }
    }
    
    func configureCell(in channel: ChatChannel) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        if channel.profileUrlString.isEmpty {
            
            self.thumnailImage.image = UIImage(named: AssetImage.defaultProfileImage)
        } else {
            
            self.thumnailImage.kf.setImage(with: URL(string: channel.profileUrlString)) { result in
                
                switch result {
                case .success(_):
                    
                    print("로드성공")
                case .failure(_):
                    
                    self.thumnailImage.image = UIImage(named: AssetImage.defaultProfileImage)
                }
            }
        }
        DispatchQueue.main.async { [weak self] in
            
            self?.name.text = channel.name
            
            if let lastMessage = channel.lastMessage {
                
                self?.date.text = dateFormatter.string(from: lastMessage.sentDate)
                
                if lastMessage.content.isEmpty {
                    
                    self?.content.text = self?.emptyContentText
                } else {
                    
                    self?.content.text = lastMessage.content
                }
            } else {
                
                self?.date.text = dateFormatter.string(from: Date())
                self?.content.text = self?.emptyContentText
            }
        }
    }
}
