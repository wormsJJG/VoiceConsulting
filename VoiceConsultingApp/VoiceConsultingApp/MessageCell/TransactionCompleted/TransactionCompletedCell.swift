//
//  TransactionCompletedCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/15.
//

import UIKit
import Then
import MessageKit
import RxSwift

class TransactionCompletedCell: CustomMessageContentCell {
    
    weak var systemMessageDelegate: MessageButtonTouchable?
    
    private let requestTypeDetail: PaddingLabel = PaddingLabel(padding: UIEdgeInsets(top: 2,
                                                                                     left: 6,
                                                                                     bottom: 2,
                                                                                     right: 6)).then {
        
        $0.text = "거래 완료 메시지"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 12)
        $0.textColor = ColorSet.mainColor
        $0.backgroundColor = ColorSet.requestLabelBack
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
    }
    
    private let requestInfo: UILabel = UILabel().then {
        
        $0.text = "결제가\n정상적으로 처리되었습니다."
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 14)
        $0.textColor = ColorSet.mainText
        $0.numberOfLines = 2
    }
    
    private lazy var topLabelStackView: UIStackView = UIStackView(arrangedSubviews: [requestTypeDetail,
                                                                                     requestInfo]).then {
        
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillProportionally
        $0.spacing = 10
    }
    
    private let coinInfoLabel: UILabel = UILabel().then {
        
        $0.textColor = ColorSet.subTextColor
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.numberOfLines = 2
        $0.text = "결제 금액: 100 코인\n환산 금액: 30,000원"
    }
    
    private let infoLabel: UILabel = UILabel().then {
        
        $0.textColor = ColorSet.mainColor
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.numberOfLines = 1
        $0.text = "상대방에게 전화를 요청하세요."
    }
    
    private lazy var midiumLabelStackView: UIStackView = UIStackView(arrangedSubviews: [coinInfoLabel,
                                                                                        infoLabel]).then {
        
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 10
    }
    
    private lazy var allLabelStackView: UIStackView = UIStackView(arrangedSubviews: [topLabelStackView, midiumLabelStackView]).then {
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 16
    }
    
    private lazy var callButton: UIButton = UIButton().then {
        
        $0.setTitle("전화하기", for: .normal)
        $0.titleLabel?.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 14)
        $0.setTitleColor(ColorSet.mainColor, for: .normal)
        $0.layer.borderColor = ColorSet.mainColor?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 4
        $0.addTarget(self, action: #selector(didTapButton), for: .touchDown)
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [allLabelStackView,
                                                                                callButton]).then {
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 20
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        
        self.messageContainerView.addSubview(allStackView)
    }
    
    override func configure(with message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView, dataSource: MessagesDataSource, and sizeCalculator: CustomLayoutSizeCalculator) {
        
        super.configure(with: message, at: indexPath, in: messagesCollectionView, dataSource: dataSource, and: sizeCalculator)
        
        let calculator = sizeCalculator as? TransactionCompletedSizeCalculator
        callButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        allStackView.frame = calculator?.requestContentFrame(for: message, at: indexPath) ?? .zero
        
        messageContainerView.isUserInteractionEnabled = true
        messageContainerView.backgroundColor = .white
    }
    
    @objc func didTapButton() {
        self.systemMessageDelegate?.didTapButton(.transactionCompleted)
    }
}
