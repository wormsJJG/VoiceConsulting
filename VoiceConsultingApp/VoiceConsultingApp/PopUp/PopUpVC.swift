//
//  PopUpVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/28.
//

// MARK: - Base PopUp
import UIKit
import Then
import SnapKit

class PopUpVC: UIViewController {
    private let backgroundColor =
    UIColor(red: 0.108, green: 0.108, blue: 0.108, alpha: 1)
        
    // MARK: - View
    var popUpView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
    }
    
    var titleLabel: UILabel = UILabel().then {
        $0.text = "title"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
        $0.textColor = ColorSet.mainText
        $0.textAlignment = .center
        $0.numberOfLines = 1
    }
    
    var contentLabel: UILabel = UILabel().then {
        $0.text = "content\ncontent\ncontent"
        $0.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 14)
        $0.textColor = ColorSet.subTextColor
        $0.textAlignment = .center
        $0.numberOfLines = 3
    }
    
    lazy var labelStackView: UIStackView = UIStackView(arrangedSubviews: [titleLabel, contentLabel]).then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.distribution = .fill
    }
    
    var cancelButton: UIButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(ColorSet.subTextColor, for: .normal)
        $0.titleLabel?.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
        $0.backgroundColor = ColorSet.line
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    var doneButton: UIButton = UIButton().then {
        $0.setTitle("네", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = UIFont(name: Fonts.NotoSansKR_Medium, size: 16)
        $0.backgroundColor = ColorSet.mainColor
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    lazy var buttonStackView: UIStackView = UIStackView(arrangedSubviews: [cancelButton, doneButton]).then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fillEqually
    }
    
    lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [labelStackView, buttonStackView]).then {
        $0.axis = .vertical
        $0.spacing = 20
        $0.distribution = .fill
    }
    // MARK: - didSet Properties
    var popUpTitle: String? {
        didSet {
            self.titleLabel.text = popUpTitle
        }
    }
    
    var popUpContent: String? {
        didSet {
            self.contentLabel.text = popUpContent
        }
    }
    
    var cancelButtonTitle: String? {
        didSet {
            self.cancelButton.setTitle(cancelButtonTitle, for: .normal)
        }
    }
    
    var doneButtonTitle: String? {
        didSet {
            self.doneButton.setTitle(doneButtonTitle, for: .normal)
        }
    }
    
    // isHidden
    
    var isHiddenTitleLabel: Bool = false {
        didSet {
            self.titleLabel.isHidden = isHiddenTitleLabel
        }
    }
    
    var isHiddenContentLabel: Bool = false {
        didSet {
            self.contentLabel.isHidden = isHiddenContentLabel
        }
    }
    
    var isHiddenCancelButton: Bool = false {
        didSet {
            self.cancelButton.isHidden = isHiddenCancelButton
        }
    }
    
    var isHiddenDoneButton: Bool = false {
        didSet {
            self.cancelButton.isHidden = isHiddenDoneButton
        }
    }

    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSubView()
        configure()
        setPopUp()
    }
    
    // MARK: - Open Func
    open func setUpSubView() {
        self.view.addSubview(popUpView)
        self.popUpView.addSubview(allStackView)
    }
    
    open func configure() {
        
        self.view.backgroundColor = backgroundColor.withAlphaComponent(0.2)
        
        popUpView.snp.makeConstraints {
            $0.left.equalTo(self.view.snp.left).offset(30)
            $0.right.equalTo(self.view.snp.right).offset(-30)
            $0.center.equalTo(self.view.snp.center)
        }
        
        cancelButton.snp.makeConstraints {
            $0.height.equalTo(46)
        }
        
        doneButton.snp.makeConstraints {
            $0.height.equalTo(46)
        }
        
        allStackView.snp.makeConstraints {
            $0.edges.equalTo(self.popUpView.snp.edges).inset(20)
        }
    }
    
    open func setPopUp() {
        self.cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    } //Use Make PopUp
    
    @objc open func cancelAction() {
        dismiss(animated: false)
    }
}
