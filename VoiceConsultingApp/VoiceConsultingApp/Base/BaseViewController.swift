//
//  BaseViewController.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/22.
//

import UIKit
import AcknowList
import Lottie
import Then
import SnapKit

class BaseViewController: UIViewController {
    
    private let animationView = LottieAnimationView(name: "LoadingAnimation")
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        isHiddenNavigationBar()
        animationViewConfigure()
    }
    // MARK: - Configure
    private func animationViewConfigure() {
        
        animationView.contentMode = .scaleAspectFit
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .loop
        animationView.isHidden = true
        animationView.layer.zPosition = 999
        
        view.addSubview(animationView)
        
        animationView.snp.makeConstraints {
            
            $0.edges.equalToSuperview()
        }
    }
    // MARK: - Util
    func isHiddenBackButton() {
        
        self.navigationItem.hidesBackButton = true
    }
    
    func isHiddenNavigationBar() {
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func playLoadAnimation() {
        
        self.animationView.isHidden = false
        self.animationView.play()
    }
    
    func stopAnimation() {
        
        self.animationView.isHidden = true
        self.animationView.stop()
    }
}
// MARK: - MoveView
extension BaseViewController {
    
    func moveChatRoomVC(_ chatChannel: ChatChannel) {
        
        let chatRoomVC = ChatRoomVC()
        chatRoomVC.setChatChannel(chatChannel)
        chatRoomVC.hidesBottomBarWhenPushed = true
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) {
            
            self.navigationController?.pushViewController(chatRoomVC, animated: true)
        }
    }
    
    func moveSplashVC() {
        let splashVC = SplashVC()
        
        self.navigationController?.pushViewController(splashVC, animated: true)
    }
    
    func moveInputCounselorInfoVC() {
        
        let inputCounselorInfoVC = InputCounselorInfoVC()
        
        self.navigationController?.pushViewController(inputCounselorInfoVC, animated: true)
    }
    
    func moveMain() {
        
        let mainVC = UINavigationController(rootViewController: CustomTabBarController())
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(vc: mainVC)
    }
    
    func moveLoginVC() {
        
        let loginVC = UINavigationController(rootViewController: LoginVC())
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(vc: loginVC)
    }
    
    func moveSelectCategoryVC() {
        
        let selectCategoryVC = SelectCategoryVC()
        
        self.navigationController?.pushViewController(selectCategoryVC, animated: true)
    }
    
    func moveInputUserInfoVC() {
        
        let inputUserInfoVC = InputUserInfoVC()
        
        self.navigationController?.pushViewController(inputUserInfoVC, animated: true)
    }
    
    func moveSelectUseTypeVC() {
        
        let selectUseTypeVC = UINavigationController(rootViewController: SelectUseTypeVC())
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVC(vc: selectUseTypeVC)
    }
    
    func moveCoinManagementVC(start: Int) {
        
        let coinManagementVC = CoinManagementVC()
        coinManagementVC.hidesBottomBarWhenPushed = true
        coinManagementVC.startIndex = start
        
        self.navigationController?.pushViewController(coinManagementVC, animated: true)
    }
    
    func moveEditCounselorInfoVC() {
        
        let inputCounselorInfo = InputCounselorInfoVC()
        inputCounselorInfo.isEditInfo()
        inputCounselorInfo.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(inputCounselorInfo, animated: true)
    }
    
    func moveCounselorDetailVC(in counselorUid: String) {
        
        let counselorDetailVC = CounselorDetailVC()
        counselorDetailVC.setCounselorUid(uid: counselorUid)
        counselorDetailVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(counselorDetailVC, animated: true)
    }
    
    func popVC() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func moveRevenueManagementVC() {
        
        let revenueManagementVC = RevenueManagementVC()
        revenueManagementVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(revenueManagementVC, animated: true)
    }
    
    func moveChatRommVC() {
        let chatRoom = ChatRoomVC()
        chatRoom.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(chatRoom, animated: true)
    }
    
    func moveAlertVC() {
        let alertVC = AlertVC()
        alertVC.hidesBottomBarWhenPushed = true
        
        self.navigationController?.pushViewController(alertVC, animated: true)
    }
    
    func moveOpenSourceLicense(){
        let acknowList = AcknowListViewController(fileNamed: "Pods-VoiceConsultingApp-acknowledgements")
        // 오픈소스 라이선스 VC 이동할떄 네비게이션바가 없으면 돌아올 방법이 없어서 네비게이션 바의 hidden을 false 한다.
        self.navigationController?.navigationBar.isHidden = false
        acknowList.hidesBottomBarWhenPushed = true
        acknowList.title = "오픈소스 라이브러리"
        navigationController?.pushViewController(acknowList, animated: true)
    }
    
    func moveTermsVC(type: HeaderType) {
        let termsVC = TermsVC()
        termsVC.type = type
        termsVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(termsVC, animated: true)
    }
    
    func moveHeartCounselorVC() {
        let heartCounselorVC = HeartCounselorVC()
        heartCounselorVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(heartCounselorVC, animated: true)
    }
    
    func showLogoutPopUp() {
        let popUp = LogoutPopUpVC()
        
        popUp.hidesBottomBarWhenPushed = true
        popUp.modalPresentationStyle = .overFullScreen
        popUp.modalTransitionStyle = .crossDissolve
        self.present(popUp, animated: true, completion: nil)
    }
    
    func showDeleteAccountPopUp() {
        let popUp = DeleteAccountPopUpVC()
        
        popUp.hidesBottomBarWhenPushed = true
        popUp.modalPresentationStyle = .overFullScreen
        popUp.modalTransitionStyle = .crossDissolve
        self.present(popUp, animated: true, completion: nil)
    }
    
    func showPopUp(popUp: PopUpVC) {
        
        popUp.hidesBottomBarWhenPushed = true
        popUp.modalPresentationStyle = .overFullScreen
        popUp.modalTransitionStyle = .crossDissolve
        self.present(popUp, animated: true, completion: nil)
    }
    
    func showErrorPopUp(errorString: String?) {
        
        let errorPopUp = ErrorPopUp()
        errorPopUp.errorString = errorString
        
        errorPopUp.hidesBottomBarWhenPushed = true
        errorPopUp.modalPresentationStyle = .overFullScreen
        errorPopUp.modalTransitionStyle = .crossDissolve
        self.present(errorPopUp, animated: true, completion: nil)
    }
    
    func moveVoiceRoom() {
        
        let voiceRoomVC = VoiceRoomVC()
        
        self.navigationController?.pushViewController(voiceRoomVC, animated: true)
    }
    
    func moveToSettleVC() {
        
        let toSettleVC = ToSettleVC()
        
        self.navigationController?.pushViewController(toSettleVC, animated: true)
    }
}

// MARK: - Keyboard Noti
extension BaseViewController {

    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object:nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
          if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                  let keyboardRectangle = keyboardFrame.cgRectValue
                  let keyboardHeight = keyboardRectangle.height - 100
              UIView.animate(withDuration: 1) {
                  self.view.window?.frame.origin.y -= keyboardHeight
              }
          }
      }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.window?.frame.origin.y != 0 {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                    let keyboardRectangle = keyboardFrame.cgRectValue
                    let keyboardHeight = keyboardRectangle.height - 100
                UIView.animate(withDuration: 1) {
                    self.view.window?.frame.origin.y += keyboardHeight
                }
            }
        }
    }
}
