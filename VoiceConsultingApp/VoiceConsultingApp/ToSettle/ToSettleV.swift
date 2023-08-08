//
//  ToSettleV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/08/01.
//

import UIKit
import Then
import SnapKit

class ToSettleV: UIView {
    
    let header: PlainHeaderView = PlainHeaderView().then {
        
        $0.headerType = .toSettle
        $0.isHiddenRefreshButton = true
    }
    
    let toSettleButton: PlainButton = PlainButton().then {
        
        $0.titleText = "정산하기"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constraints()
    }
    
    private let coinCountTitleLabel: UILabel = UILabel().then {
        
        $0.text = "보유코인"
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 14)
        $0.textColor = ColorSet.mainText
    }
    
    private let coinIconImageView: UIImageView = UIImageView().then {
        
        $0.image = UIImage(named: AssetImage.coinIconBlack)
    }
    
    let coinCountLabel: UILabel = UILabel().then {
        
        $0.text = String(Config.coin)
        $0.font = UIFont(name: Fonts.Inter_Bold, size: 20)
        $0.textColor = ColorSet.mainText
    }
    
    private lazy var coinCountRightStackView: UIStackView = UIStackView(arrangedSubviews: [coinIconImageView,
                                                                                           coinCountLabel]).then {
        
        $0.axis = .horizontal
        $0.spacing = 6
        $0.alignment = .center
    }
    
    private lazy var coinCountAllStackView: UIStackView = UIStackView(arrangedSubviews: [coinCountTitleLabel,
                                                                                         coinCountRightStackView]).then {
        
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fill
    }
    
    private let line: UIView = UIView().then {
        
        $0.backgroundColor = ColorSet.line
    }
    
    private let inputCoinCountTitleLabel: UILabel = UILabel().then {
        
        $0.text = "정산할 코인"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textColor = ColorSet.mainText
        $0.textAlignment = .left
    }
    
    let coinCountTextField: PlainTextField = PlainTextField().then {
        
        $0.placeholder = "정산할 코인갯수 입력"
        $0.textAlignment = .right
        $0.keyboardType = .numberPad
    }
    
    private lazy var inputCoinStackView: UIStackView = UIStackView(arrangedSubviews: [inputCoinCountTitleLabel,
                                                                                      coinCountTextField]).then {
        
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fillProportionally
    }
    
    private let settleGuideLabel: UILabel = UILabel().then {
        
        $0.text = "최소 100코인, 100개 단위로 환전이 가능합니다. 100개 - 30000원"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 12)
        $0.textColor = ColorSet.mainColor
        $0.textAlignment = .right
    }
    
    private lazy var inputCoinAllStackView: UIStackView = UIStackView(arrangedSubviews: [inputCoinStackView,
                                                                                         settleGuideLabel]).then {
           
        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private lazy var topStackView: UIStackView = UIStackView(arrangedSubviews: [coinCountAllStackView,
                                                                                line,
                                                                                inputCoinAllStackView]).then {
           
        $0.axis = .vertical
        $0.spacing = 20
    }
    
    private let inputAccountInfoLabel: UILabel = UILabel().then {
        
        $0.text = "계좌정보 입력"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textColor = ColorSet.mainText
    }
    
    let accountNameTextField: PlainTextField = PlainTextField().then {
        
        $0.placeholder = "은행명 입력"
    }
    
    let nameTextField: PlainTextField = PlainTextField().then {
        
        $0.placeholder = "이름 입력"
    }
    
    let accountNumberTextField: PlainTextField = PlainTextField().then {
        
        $0.placeholder = "계좌번호 입력"
        $0.keyboardType = .numberPad
    }
    
    private lazy var accountNameAndNameStackView: UIStackView = UIStackView(arrangedSubviews: [accountNameTextField,
                                                                                               nameTextField]).then {
        
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 10
        $0.distribution = .fillEqually
    }
    
    private lazy var bottomStackView: UIStackView = UIStackView(arrangedSubviews: [inputAccountInfoLabel,
                                                                                   accountNameAndNameStackView,
                                                                                   accountNumberTextField]).then {

        $0.axis = .vertical
        $0.spacing = 10
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [topStackView,
                                                                                bottomStackView]).then {

        $0.axis = .vertical
        $0.spacing = 38
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraints() {
        
        addSubview(header)
        
        header.snp.makeConstraints {
            
            $0.left.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.right.equalToSuperview()
        }
        
        addSubview(toSettleButton)
        
        toSettleButton.snp.makeConstraints {
            
            $0.height.equalTo(54)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
        line.snp.makeConstraints {
            
            $0.height.equalTo(1)
        }
        
        coinCountTextField.snp.makeConstraints {
            
            $0.width.equalTo(allStackView).multipliedBy(0.6)
        }
        
        addSubview(allStackView)
        
        allStackView.snp.makeConstraints {
            
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(header.snp.bottom).offset(20)
            $0.right.equalToSuperview().offset(-20)
        }
    }
}
