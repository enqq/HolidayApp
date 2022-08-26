//
//  HomeViewController.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 19/08/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {

    /// Depedencies
    var viewModel: HomeViewModel!
    private let disposeBag = DisposeBag()
    
    /// Properties
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    /// Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        bindNavigationItem()
        bindData()
    }
}

// MARK: Setup View
extension HomeViewController {
    private func setupView() {
        backgroundView.setRadius(10)
    }
}

// MARK: Bind Data
extension HomeViewController {
    private func bindNavigationItem() {
        clearButton.rx.tap
            .bind(to: viewModel.input.clearButton)
            .disposed(by: disposeBag)
        
        searchButton.rx.tap
            .bind(to: viewModel.input.searchButton)
            .disposed(by: disposeBag)
        
        selectButton.rx.tap
            .bind(to: viewModel.input.selectButton)
            .disposed(by: disposeBag)
    }
    
    private func bindData() {
        viewModel.output.selectedCountry
            .do(onNext: { [weak self] country in
                self?.countryLabel.isHidden = country.name.isEmpty
            })
            .map({ return "\($0.code) - \($0.name)"})
            .drive( countryLabel.rx.text )
            .disposed(by: disposeBag)
    }
}
