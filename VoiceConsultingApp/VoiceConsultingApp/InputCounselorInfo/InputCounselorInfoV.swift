//
//  InputCounselorInfoV.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/07/18.
//

import UIKit
import Then
import SnapKit

class InputCounselorInfoV: UIView {
    
    private let titleLabel: UILabel = UILabel().then {
        
        $0.text = "상담사 회원가입"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
        $0.textColor = ColorSet.mainText
    }
    
    private lazy var scrollView: UIScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
    }
    
    private lazy var contentView: UIView = UIView()
    
    private let inputProfileTitle: UILabel = UILabel().then {
        
        $0.text = "프로필 사진"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textColor = ColorSet.mainText
        $0.textAlignment = .left
    }
    
    let profileImageView: UIImageView = UIImageView().then {
        
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 40
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorSet.line?.cgColor
        $0.image = UIImage(named: AssetImage.myIconFull)
        $0.contentMode = .center
    }
    
    private lazy var inputProfileStackView: UIStackView = UIStackView(arrangedSubviews: [inputProfileTitle,
                                                                                         profileImageView]).then {
        
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.alignment = .center
        $0.spacing = 20
    }
    
    private let inputNameTitle: UILabel = UILabel().then {
        
        $0.text = "이름"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textColor = ColorSet.mainText
        $0.textAlignment = .left
    }
    
    let inputNameTextField: PlainTextField = PlainTextField().then {
        
        $0.placeholder = "실명을 입력해주세요"
    }
    
    private lazy var nameInputStackView: UIStackView = UIStackView(arrangedSubviews: [inputNameTitle,
                                                                                         inputNameTextField]).then {
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 10
    }
    
    private let inputAffiliationTitle: UILabel = UILabel().then {
        
        $0.text = "소속기관   최대 4개"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textColor = ColorSet.mainText
        $0.textAlignment = .left
    }
    
    let addAffiliationFieldButton: BaseButton = BaseButton().then {
        
        $0.setTitle("+추가", for: .normal)
        $0.setTitleColor(ColorSet.mainColor, for: .normal)
    }
    
    let affiliationTextFieldOne: PlainTextField = PlainTextField().then {
        
        $0.placeholder = "소속기관을 입력해주세요"
    }
    
    let affiliationTextFieldTwo: PlainTextField = PlainTextField().then {
        
        $0.isHidden = true
        $0.placeholder = "소속기관을 입력해주세요"
    }
    
    let affiliationTextFieldThree: PlainTextField = PlainTextField().then {
        
        $0.isHidden = true
        $0.placeholder = "소속기관을 입력해주세요"
    }
    
    let affiliationTextFieldFour: PlainTextField = PlainTextField().then {
        
        $0.isHidden = true
        $0.placeholder = "소속기관을 입력해주세요"
    }
    
    private lazy var affiliationTopStackView: UIStackView = UIStackView(arrangedSubviews: [inputAffiliationTitle,
                                                                                           addAffiliationFieldButton]).then {
        
        $0.axis = .horizontal
    }
    
    private lazy var inputAffiliationStackView: UIStackView = UIStackView(arrangedSubviews: [affiliationTopStackView,
                                                                                             affiliationTextFieldOne,
                                                                                             affiliationTextFieldTwo,
                                                                                             affiliationTextFieldThree,
                                                                                             affiliationTextFieldFour]).then {
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 10
    }
    
    private let inputCertificateTitle: UILabel = UILabel().then {
        
        $0.text = "자격증 및 활동 인증 서류"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textColor = ColorSet.mainText
        $0.textAlignment = .left
    }
    
    let widthHeight = (UIScreen.main.bounds.width / 3) - 20
    
    lazy var inputProfileImageList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: widthHeight, height: widthHeight)
        layout.minimumLineSpacing = 10.0
        
        let list = UICollectionView(frame: .zero, collectionViewLayout: layout)
        list.register(AddPhotoCell.self, forCellWithReuseIdentifier: AddPhotoCell.cellID)
        list.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.cellID)
        list.showsHorizontalScrollIndicator = false
        
        return list
    }()
    
    private lazy var inputCertificateStackView: UIStackView = UIStackView(arrangedSubviews: [inputCertificateTitle,
                                                                                             inputProfileImageList]).then {
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 10
    }
    
    private let inputIntoroduceTitle: UILabel = UILabel().then {
        
        $0.text = "소개"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textColor = ColorSet.mainText
        $0.textAlignment = .left
    }
    
    lazy var inputIntroduceField: UITextView = UITextView().then {
        $0.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        $0.textColor = ColorSet.subTextColor2
        $0.text = "상세 소개를 작성해주세요"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = ColorSet.line?.cgColor
    }
    
    private lazy var inputIntroduceStackView: UIStackView = UIStackView(arrangedSubviews: [inputIntoroduceTitle,
                                                                                            inputIntroduceField]).then {
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 10
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [inputProfileStackView,
                                                                                nameInputStackView,
                                                                                inputAffiliationStackView,
                                                                                inputCertificateStackView,
                                                                                inputIntroduceStackView]).then {
        
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 40
    }
    
    let nextButton: CompleteButton = CompleteButton().then {
        
        $0.titleText = "다음"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        constraints()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraints() {
        
        self.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            
            $0.left.equalTo(self.snp.left).offset(20)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        self.addSubview(nextButton)
        
        nextButton.snp.makeConstraints {
            
            $0.left.equalTo(self.snp.left).offset(20)
            $0.right.equalTo(self.snp.right).offset(-20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
            $0.height.equalTo(54)
        }
        
        self.addSubview(scrollView)
        
        self.scrollView.snp.makeConstraints { scrollView in
            scrollView.left.equalTo(self.snp.left)
            scrollView.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            scrollView.right.equalTo(self.snp.right)
            scrollView.bottom.equalTo(self.nextButton.snp.top).offset(-10)
        }
        
        self.scrollView.addSubview(contentView)
        
        self.contentView.snp.makeConstraints { contentView in
            contentView.edges.equalTo(self.scrollView.snp.edges)
            contentView.width.equalTo(self.scrollView.snp.width)
        }
        
        inputProfileStackView.snp.makeConstraints {
            
            $0.left.equalTo(self.allStackView.snp.left)
            $0.right.equalTo(self.allStackView.snp.right)
        }
        
        inputProfileTitle.snp.makeConstraints {
            
            $0.left.equalTo(self.allStackView.snp.left)
        }
        
        profileImageView.snp.makeConstraints {
            
            $0.height.width.equalTo(80)
        }
        
        inputProfileImageList.snp.makeConstraints {
            
            $0.height.equalTo(widthHeight)
        }
        
        inputIntroduceField.snp.makeConstraints {
            
            $0.height.equalTo(256)
        }
        
        contentView.addSubview(allStackView)
        
        allStackView.snp.makeConstraints {
            
            $0.edges.equalTo(self.contentView.snp.edges).inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
    }
}
