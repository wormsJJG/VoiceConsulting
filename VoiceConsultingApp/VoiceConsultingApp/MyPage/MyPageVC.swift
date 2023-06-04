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
        dataBind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 오픈소스 라이브러리를 갔다오면 바 히든이 풀려서 다시 해줌
        isHiddenNavigationBar()
    }
}
// MARK: - bindData

extension MyPageVC {
    
    private func dataBind() {
        DispatchQueue.main.async {
            self.myPageV.name.text = Config.name
            //프로필 코드
            //보유 코인
        }
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
        viewModel.menu.bind(to: self.myPageV.menuList.rx.items) { tableView, row, menu in
            if menu == .callNumber {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCenterCell.cellID) as? ServiceCenterCell else {
                    
                    return UITableViewCell()
                }
                
                return cell
            } else {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.cellID) as? MenuCell else {
                    
                    return UITableViewCell()
                }
                
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
                return cell
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
                case .outOfService:
                    self?.showDeleteAccountPopUp()
                case .callNumber:
                    print("callNumber")
                }
            })
            .disposed(by: self.disposeBag)
    }
}
