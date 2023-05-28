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
    var imageViews = [UIImageView(image: UIImage(named: AssetImage.counselorCover)), UIImageView(image: UIImage(named: AssetImage.counselorCover)), UIImageView(image: UIImage(named: AssetImage.counselorCover))]
    let section = CounselorInfoSection.allCases
    let targetIndexPath = IndexPath(row: 0, section: 1) // 스티키 뷰로 사용할 특정 셀의 IndexPath
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return section.count
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
            return 10
            
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
            categoryCell.categoryList.onNext(["", "", "", "", "", "", "", "", ""])
            
            return categoryCell
        case CounselorInfoSection.profile.section :
            guard let profileCell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.cellID, for: indexPath) as? ProfileCell else {
                
                return UITableViewCell()
            }
            
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
            
            affiliationCell.affiliationList.onNext(["", "", "", ""])
            
            return affiliationCell
        case CounselorInfoSection.certificate.section :
            
            guard let certificateCell = tableView.dequeueReusableCell(withIdentifier: CertificateCell.cellID, for: indexPath) as? CertificateCell else {
                
                return UITableViewCell()
            }
            
            certificateCell.certificateImageList.onNext(["", "", "", ""])
            
            return certificateCell
        case CounselorInfoSection.detailIntrodution.section :
            
            guard let detailInfoCell = tableView.dequeueReusableCell(withIdentifier: DetailIntrodutionCell.cellID, for: indexPath) as? DetailIntrodutionCell else {
                
                return UITableViewCell()
            }
            
            return detailInfoCell
        default :
            
            guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.cellID, for: indexPath) as? ReviewCell else {
                
                return UITableViewCell()
            }
            
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
            self.counselorDetailV.stikyTapView.selectItem = .introduce
        case .review:
            scrollToReviewSection()
            self.counselorDetailV.stikyTapView.selectItem = .review
        }
    }
    
    private func scrollToProfile() {
        DispatchQueue.main.async {
            self.counselorDetailV.infoList.scroll(to: .top)
        }
    }
    
    private func scrollToReviewSection() {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 2, section: CounselorInfoSection.review.section)
            self.counselorDetailV.infoList.scrollToRow(at: indexPath, at: .bottom, animated: true)
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
    }
}
// MARK: - didTapHeartButton
extension CounselorDetailVC: HeartButtonDelegate {
    func didTapHeartButton(didTap: Bool) {
        print(didTap)
    }
}
