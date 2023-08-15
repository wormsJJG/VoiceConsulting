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
import Kingfisher

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
        dataBind()
    }
}
// MARK: - bindData

extension MyPageVC {
    
    private func dataBind() {
        
        DispatchQueue.main.async {
            
            self.myPageV.name.text = Config.name
            
            if let profileUrlString = Config.profileUrlString {
                
                self.myPageV.profileImage.kf.setImage(with: URL(string: profileUrlString))
            } else {
                
                self.myPageV.profileImage.backgroundColor = .gray
            }
            self.myPageV.coinBlock.coinCount.text = String(Config.coin)
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
        
        self.myPageV.header.editAccountButton
            .rx
            .tap
            .bind(onNext: { [weak self] _ in
                
                self?.moveEditCounselorInfoVC()
            })
            .disposed(by: self.disposeBag)
    }
}

extension MyPageVC: ToggleChangeable {
    
    func didChange(isOn: Bool, menuType: MypageCounselorMenu) {
        
        if menuType == .alarmOnOff {
            
        }
        
        if menuType == .isOnlineOnOff {
            
            CounselorManager.shared.changeIsOnline(in: isOn, completion: { [weak self] error in
                
                if let error {
                    
                    print(error.localizedDescription)
                }
            })
        }
    }
}
// MARK: - Bind TableView
extension MyPageVC: UITableViewDelegate {
    
    private func bindTableView() {
        if Config.isUser {
            
            bindUserTableView()
        } else {
            
            bindCounselorTableView()
        }
    }
    // MARK: - User
    private func bindUserTableView() {
        
        viewModel.output.userMenu.bind(to: self.myPageV.menuList.rx.items) { tableView, row, menu in
            
            if menu == .callNumber {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCenterCell.cellID) as? ServiceCenterCell else {
                    
                    return UITableViewCell()
                }
                
                return cell
            } else {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.cellID) as? MenuCell else {
                    
                    return UITableViewCell()
                }
                
                cell.configureUser(menuType: menu)
                
                if menu == MypageUserMenu.alarmOnOff {
                    
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
        
        self.myPageV.menuList.rx.modelSelected(MypageUserMenu.self)
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
    
    private func bindCounselorTableView() {
        
        viewModel.output.counselorMenu.bind(to: self.myPageV.menuList.rx.items) { tableView, row, menu in
            
            if menu == .callNumber {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceCenterCell.cellID) as? ServiceCenterCell else {
                    
                    return UITableViewCell()
                }
                
                return cell
            } else {
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.cellID) as? MenuCell else {
                    
                    return UITableViewCell()
                }
                
                cell.configureCounselor(menuType: menu)
                if menu == MypageCounselorMenu.alarmOnOff {
                    
                    cell.toggleDelegate = self
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
                
                if menu == MypageCounselorMenu.isOnlineOnOff {
                    
                    cell.toggleDelegate = self
                    if let uid = FirebaseAuthManager.shared.getUserUid() {
                        
                        CounselorManager.shared.getCounselor(in: uid)
                            .map { $0.info.isOnline }
                            .subscribe(on: MainScheduler.instance)
                            .subscribe(onNext: { isOnline in
                                
                                cell.toggle.isOn = isOnline
                            })
                            .disposed(by: self.disposeBag)
                    }
                }
                return cell
            }
        }
        .disposed(by: self.disposeBag)
        
        self.myPageV.menuList.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
        
        self.myPageV.menuList.rx.modelSelected(MypageCounselorMenu.self)
            .bind(onNext: { [weak self] menu in
                
                switch menu {
                
                case .showProfile:
                    
                    if let counselorUid = FirebaseAuthManager.shared.getUserUid() {
                        
                        self?.moveCounselorDetailVC(in: counselorUid)
                    }
                case .revenueManagement:
                    self?.moveRevenueManagementVC()
                case .termsOfUse:
                    self?.moveTermsVC(type: .termsOfUse)
                case .privacyPolicy:
                    self?.moveTermsVC(type: .privacyPolicy)
                case .openSourceLib:
                    self?.moveOpenSourceLicense()
                case .alarmOnOff:
                    print("알림")
                case .isOnlineOnOff:
                    print("즉상가")
                case .logOut:
                    self?.showLogoutPopUp()
                case .outOfService:
                    self?.showDeleteAccountPopUp()
                case .callNumber:
                    print("고객센터")
                }
            })
            .disposed(by: self.disposeBag)
    }
}
