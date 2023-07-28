//
//  BuyHistoryCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import UIKit
import SnapKit
import Then

class BuyHistoryCell: UITableViewCell {
    static let cellID = "BuyHistoryCell"
    
    private lazy var coinCountLabel: UILabel = UILabel().then {
        $0.text = "코인 100개 구매"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
    }
    
    private lazy var priceLabel: UILabel = UILabel().then {
        $0.text = "10,000원"
        $0.textColor = ColorSet.mainColor
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 14)
    }
    
    private lazy var dateLabel: UILabel = UILabel().then {
        $0.text = "2023.02.22"
        $0.textColor = ColorSet.date
        $0.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 12)
    }
    
    private lazy var rightStackView: UIStackView = UIStackView(arrangedSubviews: [priceLabel, dateLabel]).then {
        $0.axis = .vertical
        $0.spacing = 8
        $0.alignment = .center
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [coinCountLabel, rightStackView]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
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
        self.contentView.addSubview(allStackView)
        
        self.allStackView.snp.makeConstraints { sv in
            sv.left.equalTo(self.contentView.snp.left).offset(20)
            sv.top.equalTo(self.contentView.snp.top).offset(20)
            sv.right.equalTo(self.contentView.snp.right).offset(-20)
            sv.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
        }
    }
    
    func configureCell(in content: BuyCoinHistory) {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.coinCountLabel.text = "코인 \(content.coin)개 구매"
            self?.priceLabel.text = "\(self!.formatCurrency(content.moneyPayment))원"
            self?.dateLabel.text = self?.convertCreateAtToString(content.createAt)
        }
    }
    
    func convertCreateAtToString(_ timestamp: Int) -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    func formatCurrency(_ value: Int) -> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
}
