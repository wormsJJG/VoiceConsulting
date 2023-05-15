//
//  RequestTransactionCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/11.
//

import UIKit
import SnapKit
import Then
import MessageKit

class RequestTransactionCell: CustomMessageContentCell {
    private let requestTypeDetail: PaddingLabel = PaddingLabel(padding: UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)).then {
        $0.text = "거래 요청 메세지"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 12)
        $0.textColor = ColorSet.mainColor
        $0.backgroundColor = ColorSet.requestLabelBack
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
    }
    
    private let requestInfo: UILabel = UILabel().then {
        $0.text = "상대방이 거래를\n요청했습니다."
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 14)
        $0.textColor = ColorSet.mainText
        $0.numberOfLines = 2
    }
    
    private let paymentButton: UIButton = UIButton().then {
        $0.setTitle("결제하기", for: .normal)
        $0.titleLabel?.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 14)
        $0.setTitleColor(ColorSet.mainColor, for: .normal)
        $0.layer.borderColor = ColorSet.mainColor?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 4
    }
    
    private lazy var labelStackView: UIStackView = UIStackView(arrangedSubviews: [requestTypeDetail, requestInfo]).then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 10
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [labelStackView, paymentButton]).then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 20
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
//        requestInfo.text = nil
//        requestTypeDetail.text = nil
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        self.messageContainerView.addSubview(allStackView)
        layoutIfNeeded()
    }
    
    override func configure(with message: MessageType, at indexPath: IndexPath, in messageCollectionView: MessagesCollectionView, dataSource: MessagesDataSource, and sizeCalculator: CustomLayoutSizeCalculator) {
        super.configure(with: message, at: indexPath, in: messageCollectionView, dataSource: dataSource, and: sizeCalculator)
        let calculator = sizeCalculator as? RequestTranscationSizeCalculator
        allStackView.frame = calculator?.requestContentFrame(for: message, at: indexPath) ?? .zero
        paymentButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.messageContainerView.backgroundColor = .white
    }
}
