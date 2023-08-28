//
//  BuyCoinView.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/11.
//

import UIKit
import Then
import SnapKit

class BuyCoinV: UIView {
    private lazy var scrollView: UIScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = ColorSet.chattingListHeader
    }
    
    private lazy var contentView: UIView = UIView()
    
    private lazy var subTextLabel: UILabel = UILabel().then {
        $0.text = "현재 보유중인 코인"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
    }
    
    private lazy var coinImage: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AssetImage.coinIconFill)
    }
    
    lazy var coinCount: UILabel = UILabel().then {
        $0.text = "150000코인"
        $0.textColor = ColorSet.mainText
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 16)
    }
    
    private lazy var coinStackView: UIStackView = UIStackView(arrangedSubviews: [coinImage, coinCount]).then {
        $0.axis = .horizontal
        $0.spacing = 6
        $0.alignment = .center
    }
    
    private lazy var allCoinStackView: UIStackView = UIStackView(arrangedSubviews: [subTextLabel, coinStackView]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
    }
    
    private lazy var buyCoinTitle: UILabel = UILabel().then {
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 16)
        $0.text = "코인 충전"
        $0.textColor = ColorSet.mainText
    }
    
    lazy var fitstCell: BuyCoinCell = BuyCoinCell().then {
        $0.coinCount = 100
        $0.price = "65,000원 구매"
    }
    
    lazy var twoCell: BuyCoinCell = BuyCoinCell().then {
        $0.coinCount = 200
        $0.price = "130,000원 구매"
    }

    lazy var threeCell: BuyCoinCell = BuyCoinCell().then {
        $0.coinCount = 300
        $0.price = "195,000원 구매"
    }

    lazy var fourCell: BuyCoinCell = BuyCoinCell().then {
        $0.coinCount = 400
        $0.price = "280,000원 구매"
    }
    
    lazy var fiveCell: BuyCoinCell = BuyCoinCell().then {
        $0.coinCount = 500
        $0.price = "345,000원 구매"
    }
    
    private lazy var cellList: UIStackView = UIStackView(arrangedSubviews: [fitstCell, twoCell, threeCell, fourCell, fiveCell]).then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fill
    }
    
    private let informationUseTitle: UILabel = UILabel().then {
        $0.text = "이용안내"
        $0.textColor = ColorSet.subTextColor2
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
    }
    
    private let informationUseContent: UILabel = UILabel().then {
        $0.text = CoinInformationUse.content
        $0.textColor = ColorSet.subTextColor2
        $0.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 12)
        $0.numberOfLines = 0
    }
    
    private lazy var informationUseSV: UIStackView = UIStackView(arrangedSubviews: [informationUseTitle, informationUseContent]).then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 10
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
        textColorChange()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        
        self.coinImage.snp.makeConstraints {
            $0.width.height.equalTo(16)
        }
        self.addSubview(allCoinStackView)
        
        self.allCoinStackView.snp.makeConstraints { sv in
            sv.left.equalTo(self.snp.left).offset(20)
            sv.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(117)
            sv.right.equalTo(self.snp.right).offset(-20)
        }
        
        self.addSubview(scrollView)
        
        self.scrollView.snp.makeConstraints { scrollView in
            scrollView.left.equalTo(self.snp.left)
            scrollView.top.equalTo(self.allCoinStackView.snp.bottom).offset(20)
            scrollView.right.equalTo(self.snp.right)
            scrollView.bottom.equalTo(self.snp.bottom)
        }
        
        self.scrollView.addSubview(contentView)
        
        self.contentView.snp.makeConstraints { contentView in
            contentView.edges.equalTo(self.scrollView.snp.edges)
            contentView.width.equalTo(self.scrollView.snp.width)
        }
        
        self.contentView.addSubview(buyCoinTitle)
        
        self.buyCoinTitle.snp.makeConstraints { label in
            label.left.equalTo(self.contentView.snp.left).offset(20)
            label.top.equalTo(self.contentView.snp.top).offset(20)
        }
        
        self.contentView.addSubview(cellList)
        
        self.cellList.snp.makeConstraints { list in
            list.left.equalTo(self.contentView.snp.left).offset(20)
            list.top.equalTo(self.buyCoinTitle.snp.bottom).offset(20)
            list.right.equalTo(self.contentView.snp.right).offset(-20)
        }
        
        self.contentView.addSubview(informationUseSV)
        
        self.informationUseSV.snp.makeConstraints { sv in
            sv.left.equalTo(self.contentView.snp.left).offset(20)
            sv.top.equalTo(self.cellList.snp.bottom).offset(40)
            sv.right.equalTo(self.contentView.snp.right).offset(-20)
            sv.bottom.equalTo(self.contentView.snp.bottom).offset(-20)
        }
    }
    
    private func textColorChange() {
        guard let text = self.coinCount.text else { return }
        let attributeString = NSMutableAttributedString(string: text)

        attributeString.addAttribute(.foregroundColor, value: ColorSet.mainColor!, range: (text as NSString).range(of: text.filter { $0.isNumber }))

        // myLabel에 방금 만든 속성을 적용합니다.
        self.coinCount.attributedText = attributeString
    }
}
