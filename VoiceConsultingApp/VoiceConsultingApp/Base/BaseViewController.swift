//
//  BaseViewController.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/22.
//

import UIKit
import AcknowList

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        isHiddenNavigationBar()
    }
    // MARK: - Util
    
    func isHiddenBackButton() {
        self.navigationItem.hidesBackButton = true
    }
    
    func isHiddenNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
    // MARK: - MoveView
    
    func moveCoinManagementVC(start: Int) {
        let coinManagementVC = CoinManagementVC()
        coinManagementVC.hidesBottomBarWhenPushed = true
        coinManagementVC.startIndex = start
        
        self.navigationController?.pushViewController(coinManagementVC, animated: true)
    }
    
    func popVC() {
        self.navigationController?.popViewController(animated: true)
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
