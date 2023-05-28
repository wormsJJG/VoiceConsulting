//
//  EndConsultationCell.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/16.
//

import UIKit
import MessageKit
import Then
import RxSwift
import RxCocoa
import SnapKit
import RxGesture

class EndConsultationCell: CustomMessageContentCell {
    weak var systemMessageDelegate: MessageButtonTouchable?
    private let disposeBag = DisposeBag()
    
    private let requestTypeDetail: PaddingLabel = PaddingLabel(padding: UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)).then {
        $0.text = "상담 종료 메시지"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 12)
        $0.textColor = ColorSet.mainColor
        $0.backgroundColor = ColorSet.requestLabelBack
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
    }
    
    private let requestInfo: UILabel = UILabel().then {
        $0.text = "상대방과의 통화가\n성공적으로 종료되었습니다."
        $0.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 14)
        $0.textColor = ColorSet.mainText
        $0.numberOfLines = 2
    }
    
    private lazy var topLabelStackView: UIStackView = UIStackView(arrangedSubviews: [requestTypeDetail, requestInfo]).then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillProportionally
        $0.spacing = 10
    }
    
    private let infoLabel: UILabel = UILabel().then {
        $0.textColor = ColorSet.mainColor
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.numberOfLines = 2
        $0.text = "상담이 만족스러우셨다면,\n상담사에게 리뷰를 남겨주세요!"
    }
    
    private lazy var midiumLabelStackView: UIStackView = UIStackView(arrangedSubviews: [topLabelStackView, infoLabel]).then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 16
    }
    
    lazy var writeReviewButton: UIButton = UIButton().then {
        $0.setTitle("리뷰쓰기", for: .normal)
        $0.titleLabel?.font = UIFont(name: Fonts.NotoSansKR_Bold, size: 14)
        $0.setTitleColor(ColorSet.mainColor, for: .normal)
        $0.layer.borderColor = ColorSet.mainColor?.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
        $0.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [midiumLabelStackView, writeReviewButton]).then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 20
    }
    
    override func setupSubviews() {
        super.setupSubviews()
        messageContainerView.addSubview(allStackView)
    }
    
    override func configure(with message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView, dataSource: MessagesDataSource, and sizeCalculator: CustomLayoutSizeCalculator) {
        super.configure(with: message, at: indexPath, in: messagesCollectionView, dataSource: dataSource, and: sizeCalculator)
        let calculator = sizeCalculator as? EndConsultationSizeCalculator
        messageContainerView.isUserInteractionEnabled = true
        
        writeReviewButton.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        allStackView.frame = calculator?.requestContentFrame(for: message, at: indexPath) ?? .zero
        self.messageContainerView.backgroundColor = .white
    }
    
    @objc func didTapButton() {
        self.systemMessageDelegate?.didTapButton(.endConsultation)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
