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
import PureLayout

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
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        addAction()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.counselorDetailV.heightC.constant = self.counselorDetailV.infoList.contentSize.height
        print(self.counselorDetailV.infoList.contentSize.height)
        print(self.counselorDetailV.scrollView.frame.height)
        self.view.setNeedsLayout()
    }
    // MARK: - setDelegates
    private func setDelegates() {
        self.counselorDetailV.tapView.delegate = self
        self.counselorDetailV.infoList.delegate = self
        self.counselorDetailV.infoList.dataSource = self
        self.counselorDetailV.scrollView.delegate = self
    }
}
extension CounselorDetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // TapView가 가려지는 타이밍을 계산
        let shouldShowSticky = scrollView.contentOffset.y >= self.counselorDetailV.tapView.frame.minY
        self.counselorDetailV.stikyTapView.isHidden = !shouldShowSticky
    }
}
extension CounselorDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return section.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case CounselorInfoSection.affiliation.section:
            return 1
        case CounselorInfoSection.certificate.section:
            return 1
        case CounselorInfoSection.review.section:
            return 20

        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            guard let affiliationCell = tableView.dequeueReusableCell(withIdentifier: AffiliationCell.cellID, for: indexPath) as? AffiliationCell else {
                
                return UITableViewCell()
            }
            
            affiliationCell.affiliationList.onNext(["", "", "", ""])
            
            return affiliationCell
        } else if indexPath.section == 1 {
            
            guard let certificateCell = tableView.dequeueReusableCell(withIdentifier: CertificateCell.cellID, for: indexPath) as? CertificateCell else {
                
                return UITableViewCell()
            }
            
            certificateCell.certificateImageList.onNext(["", "", "", ""])
            
            return certificateCell
        } else {
            
            guard let reviewCell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.cellID, for: indexPath) as? ReviewCell else {
                
                return UITableViewCell()
            }
            
            return reviewCell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
// MARK: - CustomTabbar
extension CounselorDetailVC: CustomTabDelegate {
    func didSelectItem(_ item: CustomTabItem) {
        switch item {
        case .introduce:
            self.counselorDetailV.scrollView.scroll(to: .top)
            self.counselorDetailV.infoList.scroll(to: .top)
        case .review:
            self.counselorDetailV.scrollView.scroll(to: .bottom)
            scrollToReviewSection()
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
