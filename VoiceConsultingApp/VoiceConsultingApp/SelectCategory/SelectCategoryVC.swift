//
//  SelectCategoryVC.swift
//  VoiceConsultingApp
//
//  Created by 정재근 on 2023/03/30.
//

import UIKit
import RxSwift
import RxCocoa

class SelectCategoryVC: BaseViewController {
    // MARK: - Load View
    private let selectCategoryV = SelectCategoryV()
    
    override func loadView() {
        self.view = selectCategoryV
    }
    // MARK: - Properties
    private let viewModel = SelectCategoryVM()
    private let disposeBag = DisposeBag()
    
    // MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        bindCategoryList()
        bindOutput()
        addCompleteButtonAction()
    }
}
// MARK: - CategoryList Bind, Cell FlowLayout
extension SelectCategoryVC: UICollectionViewDelegateFlowLayout {
    private func bindCategoryList() {
        
        selectCategoryV.categoryList.rx.setDelegate(self)
            .disposed(by: self.disposeBag)
        // DataSource
        viewModel.output.categoryList
            .bind(to: self.selectCategoryV.categoryList.rx.items(cellIdentifier: CategoryCell.cellID, cellType: CategoryCell.self)) { index, category, cell in
                
                cell.configure(category: category)
            }
            .disposed(by: self.disposeBag)
        // Data Logic - select, deselect
        self.selectCategoryV.categoryList.rx
            .modelSelected(CategoryType.self)
            .map { $0.modelId }
            .subscribe(onNext: { [weak self] modelId in
                
                if let index = self?.viewModel.input.userSelectCategoryList.firstIndex(of: modelId) {
                    
                    self?.viewModel.input.userSelectCategoryList.remove(at: index)
                } else {
                    
                    self?.viewModel.input.userSelectCategoryList.append(modelId)
                }
            })
            .disposed(by: self.disposeBag)
        // UI - select, deselect
        self.selectCategoryV.categoryList.rx.itemSelected
            .bind(onNext: { [weak self] indexPath in
                
                let cell = self?.selectCategoryV.categoryList.cellForItem(at: indexPath) as! CategoryCell
                cell.isChecked = !cell.isChecked
            })
            .disposed(by: self.disposeBag)
    }
    
    //cell Width height
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let margin: CGFloat = 40
        let width: CGFloat = collectionView.bounds.width - margin
        let height: CGFloat = 116
        
        return CGSize(width: width, height: height)
    }
}
// MARK: - button Action
extension SelectCategoryVC {
    
    private func addCompleteButtonAction() {
        
        self.selectCategoryV.completeButton.rx.tap
            .bind(onNext: { [weak self] _ in
                
                self?.viewModel.input.didTapCompleteButton.onNext(())
            })
            .disposed(by: self.disposeBag)
    }
}
// MARK: - Output Bind
extension SelectCategoryVC {
    
    private func bindOutput() {
        
        self.viewModel.output.completion
            .bind(onNext: { [weak self] error in
                
                if let error {
                    
                    print(error)
                } else {
                    
                    self?.moveMain()
                }
            })
            .disposed(by: self.disposeBag)
    }
}
