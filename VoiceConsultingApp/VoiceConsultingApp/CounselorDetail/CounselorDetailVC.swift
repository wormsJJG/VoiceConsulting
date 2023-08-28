//
//  CounselorDetailVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/04/29.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture
import Tabman
import Toast_Swift

class CounselorDetailVC: BaseViewController {
    // MARK: - Load View
    private var counselorDetailV: CounselorDetailV!
    
    override func loadView() {
        super.loadView()
        
        counselorDetailV = CounselorDetailV(frame: self.view.frame)
        self.view = counselorDetailV
    }
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let viewModel = CounselorDetailVM()
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outputSubscribe()
        setDelegates()
        addAction()
    }
    // MARK: - setDelegates
    private func setDelegates() {
        
        self.counselorDetailV.infoList.delegate = self
        self.counselorDetailV.infoList.dataSource = self
        self.counselorDetailV.stikyTapView.delegate = self
        self.counselorDetailV.header.heartButton.delegate = self
    }
    // MARK: - Output SubScribe
    private func outputSubscribe() {
        
        viewModel.output.reloadTrigger
            .subscribe(onNext: { [weak self] _ in
                    
                self?.counselorDetailV.header.counselorLabel.text = self?.viewModel.output.counselor!.info.name
                self?.counselorDetailV.infoList.reloadData()
            })
            .disposed(by: self.disposeBag)
        
        viewModel.output.isHeartCounselor
            .subscribe(onNext: { [weak self] isHeart in

                self?.counselorDetailV.header.heartButton.isHeart = isHeart
            })
            .disposed(by: self.disposeBag)
        
        viewModel.output.completedCheckIsOnline
            .bind(onNext: { [weak self] isOnline in
                
                self?.didCompletedCheckIsOnline(isOnline)
            })
            .disposed(by: self.disposeBag)
        
        viewModel.output.errorTrigger
            .subscribe(onNext:{ [weak self] error in
                
                self?.showErrorPopUp(errorString: error.localizedDescription)
            })
            .disposed(by: self.disposeBag)
    }
    
    func setCounselorUid(uid: String) {
        
        viewModel.input.getDataTrigger.onNext(uid)
    }
    
    private func didCompletedCheckIsOnline(_ isOnline: Bool) {
        
        if isOnline {
            
        } else {
            
            let noOnlineCounselorPopUp = NoOnlineCounselorPopUp()
            noOnlineCounselorPopUp.setCallBack(didTapOkButtonCallBack: { [weak self] in
                
                self?.addChatChannel()
            })
            
            showPopUp(popUp: noOnlineCounselorPopUp)
        }
    }
    
    private func addChatChannel() {
        
        guard let counselor = viewModel.output.counselor else { return }
        let chatChannel = ChatChannel()
        chatChannel.uid = counselor.uid
        chatChannel.name = counselor.info.name
        chatChannel.profileUrlString = counselor.info.profileImageUrl
        
        if ChatChannelStorage.shared.isExistChannel(by: chatChannel.uid) {
            
            self.moveChatRoomVC(chatChannel)
        } else {
            
            ChatChannelStorage.shared.addChatChannelCompletion(chatChannel: chatChannel, completion: { [weak self] error in
                
                if let error {
                    
                    self?.showErrorPopUp(errorString: error.localizedDescription)
                } else {
                    
                    self?.moveChatRoomVC(chatChannel)
                }
            })
        }
    }
}
extension CounselorDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // TapView가 가려지는 타이밍을 계산
        let indexPathsForVisibleRows = self.counselorDetailV.infoList.indexPathsForVisibleRows

        // 셀이 보이는지 확인
        let stikyTapIsHidden = indexPathsForVisibleRows?.contains { indexPath in
            
            return indexPath.section == CounselorInfoSection.tapView.section && indexPath.row == 0
        } ?? false
        
        let reviewShow = indexPathsForVisibleRows?.contains { indexPath in
            
            return indexPath.section == CounselorInfoSection.review.section && indexPath.row == 2 ||
            indexPath.section == CounselorInfoSection.review.section && indexPath.row > 2
        } ?? false

        self.counselorDetailV.stikyTapView.isHidden = stikyTapIsHidden
        
        if !stikyTapIsHidden {
            
            if reviewShow {
                
                self.counselorDetailV.stikyTapView.selectItem = .review
            } else {
                
                self.counselorDetailV.stikyTapView.selectItem = .review
                self.counselorDetailV.stikyTapView.selectItem = .introduce
            }
        }
    }
}
extension CounselorDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return viewModel.output.section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            
        case CounselorInfoSection.category.section :
            
            return 1
        case CounselorInfoSection.profile.section :
            
            return 1
        case CounselorInfoSection.tapView.section :
            
            return 1
        case CounselorInfoSection.affiliation.section :
            
            return 1
        case CounselorInfoSection.certificate.section :
            
            return 1
        case CounselorInfoSection.detailIntrodution.section :
            
            return 1
        case CounselorInfoSection.review.section :
            
            guard let reviewList = self.viewModel.output.reviewList else {
                
                return 1
            }
            
            return reviewList.count == 0 ? 1 : reviewList.count
        default:
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case CounselorInfoSection.category.section :
            
            guard let categoryCell = tableView.dequeueReusableCell(withIdentifier: CategoryTVCell.cellID, for: indexPath) as? CategoryTVCell else {
                
                return UITableViewCell()
            }
            categoryCell.categoryList.onNext(self.viewModel.output.counselor?.info.categoryList ?? [])
            
            return categoryCell
        case CounselorInfoSection.profile.section :
            
            guard let profileCell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.cellID, for: indexPath) as? ProfileCell else {
                
                return UITableViewCell()
            }
            profileCell.configureCell(profileUrl: self.viewModel.output.counselor?.info.profileImageUrl ?? "",
                                      name: self.viewModel.output.counselor?.info.name ?? "",
                                      introduce: self.viewModel.output.counselor?.info.introduction ?? "")
            
            return profileCell
        case CounselorInfoSection.tapView.section :
            
            guard let tapViewCell = tableView.dequeueReusableCell(withIdentifier: TapViewCell.cellID, for: indexPath) as? TapViewCell else {
                
                return UITableViewCell()
            }
            tapViewCell.tapView.delegate = self
            
            return tapViewCell
        case CounselorInfoSection.affiliation.section :
            
            guard let affiliationCell = tableView.dequeueReusableCell(withIdentifier: AffiliationCell.cellID, for: indexPath) as? AffiliationCell else {
                
                return UITableViewCell()
            }
            
            affiliationCell.affiliationList.onNext(self.viewModel.output.counselor?.info.affiliationList ?? [])
            
            return affiliationCell
        case CounselorInfoSection.certificate.section :
            
            guard let certificateCell = tableView.dequeueReusableCell(withIdentifier: CertificateCell.cellID, for: indexPath) as? CertificateCell else {
                
                return UITableViewCell()
            }
            
            certificateCell.certificateImageList.onNext(self.viewModel.output.counselor?.info.licenseImages ?? [])
            
            return certificateCell
        case CounselorInfoSection.detailIntrodution.section :
            
            guard let detailInfoCell = tableView.dequeueReusableCell(withIdentifier: DetailIntrodutionCell.cellID, for: indexPath) as? DetailIntrodutionCell else {
                
                return UITableViewCell()
            }
            
            detailInfoCell.configureCell(in: self.viewModel.output.counselor?.info.introduction ?? "")
            
            return detailInfoCell
        default :
            
            guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.cellID, for: indexPath) as? ReviewCell else {
                
                return UITableViewCell()
            }
            
            guard let reviewList = self.viewModel.output.reviewList else {
                
                reviewCell.configureCell(in: Review(content: "등록된 후기가 없습니다.",
                                                    counselorId: "",
                                                    score: 5.0,
                                                    userId: "",
                                                    createAt: Int(Date().timeIntervalSince1970)))
                
                return reviewCell
            }
            
            if reviewList.count == 0 {
                
                reviewCell.configureCell(in: Review(content: "등록된 후기가 없습니다.",
                                                    counselorId: "",
                                                    score: 5.0,
                                                    userId: "",
                                                    createAt: Int(Date().timeIntervalSince1970)))
                
                return reviewCell
            }
            
            reviewCell.configureCell(in: reviewList[indexPath.row])
            
            return reviewCell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case CounselorInfoSection.category.section :
            
            guard let categoryHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: InfoSectionHeader.headerID) as? InfoSectionHeader else {
                return nil
            }
            
            categoryHeader.sectionTitle = CounselorInfoSection.category.title
            
            return categoryHeader
        case CounselorInfoSection.affiliation.section:
            
            guard let affiliationHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: InfoSectionHeader.headerID) as? InfoSectionHeader else {
                return nil
            }
            
            affiliationHeader.sectionTitle = CounselorInfoSection.affiliation.title
            
            return affiliationHeader
        case CounselorInfoSection.certificate.section:
            
            guard let certificateHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: InfoSectionHeader.headerID) as? InfoSectionHeader else {
                return nil
            }
            
            certificateHeader.sectionTitle = CounselorInfoSection.certificate.title
            
            return certificateHeader
        case CounselorInfoSection.detailIntrodution.section:
            guard let detailIntrodutionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: InfoSectionHeader.headerID) as? InfoSectionHeader else {
                return nil
            }
            
            detailIntrodutionHeader.sectionTitle = CounselorInfoSection.detailIntrodution.title
            
            return detailIntrodutionHeader
            
        case CounselorInfoSection.review.section:
            
            guard let reviewHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: InfoSectionHeader.headerID) as? InfoSectionHeader else {
                return nil
            }
            
            reviewHeader.sectionTitle = CounselorInfoSection.review.title
            
            return reviewHeader
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 || section == 1 {
            
            return 0
        } else {
            
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
    }
}
// MARK: - CustomTabbar
extension CounselorDetailVC: CustomTabDelegate {
    func didSelectItem(_ item: CustomTabItem) {
        
        switch item {
            
        case .introduce:
            
            scrollToProfile()
        case .review:
            
            scrollToReviewSection()
        }
    }
    
    private func scrollToProfile() {
        
        DispatchQueue.main.async {
            
            self.counselorDetailV.infoList.scroll(to: .top)
            self.counselorDetailV.stikyTapView.selectItem = .introduce
        }
    }
    
    private func scrollToReviewSection() {
        
        guard let reviewList = viewModel.output.reviewList else {
            
            self.view.makeToast("등록된 후기가 없습니다.")
            return
        }
        
        if reviewList.count > 2 {
            
            DispatchQueue.main.async {
                
                let indexPath = IndexPath(row: 2, section: CounselorInfoSection.review.section)
                self.counselorDetailV.infoList.scrollToRow(at: indexPath, at: .bottom, animated: true)
                self.counselorDetailV.stikyTapView.selectItem = .review
            }
        } else if reviewList.count == 0 {
            
            self.view.makeToast("등록된 후기가 없습니다.")
        } else {
            
            DispatchQueue.main.async {
                
                let indexPath = IndexPath(row: 0, section: CounselorInfoSection.review.section)
                self.counselorDetailV.infoList.scrollToRow(at: indexPath, at: .bottom, animated: true)
                self.counselorDetailV.stikyTapView.selectItem = .review
            }
        }
    }
}

// MARK: - addAction
extension CounselorDetailVC {
    
    private func addAction() {
        
        counselorDetailV.header.backButton.rx.tap
            .bind(onNext: { [weak self] _ in
                
                self?.popVC()
            })
            .disposed(by: self.disposeBag)
        
        counselorDetailV.startConsultButton.rx.tap
            .bind(onNext: { [weak self] _ in
                
                if Config.isUser {
                    
                    self?.viewModel.input.didTapConsultingButton.onNext((self?.viewModel.output.counselor!.uid)!)
                } else {
                    
                    self?.showLimitPopUp()
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    func showLimitPopUp() {
        
        let popUp = OneButtonNoActionPopUpVC()
        popUp.popUpContent = "상담사는 상담이 불가능합니다."
        
        self.showPopUp(popUp: popUp)
    }
}
// MARK: - didTapHeartButton
extension CounselorDetailVC: HeartButtonDelegate {
    
    func didTapHeartButton(didTap: Bool) {
        
        viewModel.didTapHeartButtonAction(in: didTap)
    }
}
