//
//  InputView.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/05/30.
//

import UIKit
import Then
import SnapKit

class CustomInputView: UIInputView {
    
    private let albumButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: AssetImage.albumIcon), for: .normal)
        $0.backgroundColor = ColorSet.line
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 23
        $0.setTitle(nil, for: .normal)
    }
    
    private let albumLabel: UILabel = UILabel().then {
        $0.text = "앨범"
        $0.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 14)
        $0.textColor = ColorSet.mainText
        $0.numberOfLines = 1
        $0.textAlignment = .center
    }
    
    private lazy var albumStackView: UIStackView = UIStackView(arrangedSubviews: [albumButton, albumLabel]).then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .fill
    }
    
    private let cameraButton: UIButton = UIButton().then {
        $0.setImage(UIImage(named: AssetImage.cameraIcon), for: .normal)
        $0.backgroundColor = ColorSet.line
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 23
        $0.setTitle(nil, for: .normal)
    }
    
    private let cameraLabel: UILabel = UILabel().then {
        $0.text = "카메라"
        $0.font = UIFont(name: Fonts.NotoSansKR_Regular, size: 14)
        $0.textColor = ColorSet.mainText
        $0.numberOfLines = 1
        $0.textAlignment = .center
    }
    
    private lazy var cameraStackView: UIStackView = UIStackView(arrangedSubviews: [cameraButton, cameraLabel]).then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.distribution = .fill
    }
    
    private lazy var allStackView: UIStackView = UIStackView(arrangedSubviews: [albumStackView, cameraStackView]).then {
        $0.axis = .horizontal
        $0.spacing = 80
    }

    override init(frame: CGRect, inputViewStyle: UIInputView.Style) {
        super.init(frame: frame, inputViewStyle: inputViewStyle)
        configureView()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func constraints() {
        
        self.albumButton.snp.makeConstraints {
            $0.width.height.equalTo(46)
        }
        self.cameraButton.snp.makeConstraints {
            $0.width.height.equalTo(46)
        }

        self.addSubview(allStackView)

        self.allStackView.snp.makeConstraints {
            $0.center.equalTo(self.snp.center)
        }
    }
}
