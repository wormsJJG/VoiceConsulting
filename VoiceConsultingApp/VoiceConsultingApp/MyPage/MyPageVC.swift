//
//  MyPageVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/10.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class MyPageVC: BaseViewController {
    // MARK: - Load View
    private let myPageV = MyPageV()
    
    override func loadView() {
        self.view = myPageV
    }
    // MARK: - Properties
    private let viewModel = MypageVM()
    private let disposeBag = DisposeBag()
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapAction()
        bindTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 오픈소스 라이브러리를 갔다오면 바 히든이 풀려서 다시 해줌
        isHiddenNavigationBar()
    }
}
// MARK: - Touch Action
extension MyPageVC {
    
    private func addTapAction() {
        self.myPageV.coinBlock.rx
            .tapGesture()
            .when(.recognized)
            .bind(onNext: { [weak self] _ in
                self?.moveCoinManagementVC(start: 0)
            })
            .disposed(by: self.disposeBag)
        
        self.myPageV.header.alarmButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.moveAlertVC()
            })
            .disposed(by: self.disposeBag)
    }
}
// MARK: - Bind TableView
extension MyPageVC: UITableViewDelegate {
    private func bindTableView() {
        viewModel.menu.bind(to: self.myPageV.menuList.rx.items(cellIdentifier: MenuCell.cellID, cellType: MenuCell.self)) { index, menu, cell in
            cell.configure(menuType: menu)
            
            if menu == MypageMenu.alarmOnOff {
                UNUserNotificationCenter.current().getNotificationSettings { settings in
                    DispatchQueue.main.async {
                        switch settings.alertSetting {
                        case .enabled:
                            cell.toggle.isOn = true
                        default:
                            cell.toggle.isOn = false
                        }
                    }
                }
            }
        }
        .disposed(by: self.disposeBag)
        
        self.myPageV.menuList.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
        
        self.myPageV.menuList.rx.modelSelected(MypageMenu.self)
            .bind(onNext: { [weak self] menu in
                switch menu {
                case .heartCounselor:
                    self?.moveHeartCounselorVC()
                case .consultingHistory:
                    self?.moveCoinManagementVC(start: 2)
                case .termsOfUse:
                    self?.moveTermsVC(type: .termsOfUse)
                case .privacyPolicy:
                    self?.moveTermsVC(type: .privacyPolicy)
                case .openSourceLib:
                    self?.moveOpenSourceLicense()
                case .alarmOnOff:
                    print("알림")
                case .logOut:
                    self?.showLogoutPopUp()
                case .OutOfService:
                    self?.showDeleteAccountPopUp()
                }
            })
            .disposed(by: self.disposeBag)
    }
}
