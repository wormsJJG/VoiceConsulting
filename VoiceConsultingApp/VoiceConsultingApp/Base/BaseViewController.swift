//
//  BaseViewController.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/22.
//

import UIKit
import AcknowList
import AgoraChat

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        isHiddenNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    // MARK: - Util
    
    func isHiddenBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func isHiddenNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    // MARK: - MoveView
    
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
    
    func moveVoiceRoom() {
        
        let voiceRoomVC = VoiceRoomVC()
        
        self.navigationController?.pushViewController(voiceRoomVC, animated: true)
    }
    
    func moveToSettleVC() {
        
        let toSettleVC = ToSettleVC()
        
        self.navigationController?.pushViewController(toSettleVC, animated: true)
    }
    
    // MARK: - KeyBoard
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

extension BaseViewController: AgoraChatManagerDelegate, AgoraChatClientDelegate {
    
    private func registerNotifications() {
        self.unregisterNotifications()
        AgoraChatClient.shared.add(self, delegateQueue: nil)
        AgoraChatClient.shared().chatManager?.add(self, delegateQueue: nil)
    }
    
    private func unregisterNotifications() {
        AgoraChatClient.shared.removeDelegate(self)
        AgoraChatClient.shared.chatManager?.remove(self)
    }
    
    func messagesDidReceive(_ aMessages: [AgoraChatMessage]) {
        
        for message in aMessages {
            
            let state = UIApplication.shared.applicationState
            switch state {
                
            case .inactive, .active:
                
                showLocalNotification(in: message)
            case .background:
                
                showLocalNotification(in: message)
            default:
                
                break
            }
        }
    }
    
    private func showLocalNotification(in message: AgoraChatMessage) {
        
        guard let ext = message.ext,
              let apnsItem = ext["em_apns_ext"],
              let convertApns = apnsItem as? [String: Any],
              let senderName = convertApns["senderName"] as? String,
              let message = convertApns["message"] as? String else { return }
        
        let content = UNMutableNotificationContent()
        content.title = senderName
        content.body = message
        
        let request = UNNotificationRequest(identifier: "agoraChat", content: content, trigger: .none)
        UNUserNotificationCenter.current().add(request)
    }
}
