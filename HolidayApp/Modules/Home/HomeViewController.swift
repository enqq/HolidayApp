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
    @IBOutlet weak var showHolidayButton: UIButton!
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
        showHolidayButton.isEnabled = false
    }
}

// MARK: Bind Data
extension HomeViewController {
    private func bindNavigationItem() {
        clearButton.rx.tap
            .bind(to: viewModel.input.clearButton)
            .disposed(by: disposeBag)
        
        showHolidayButton.rx.tap
            .bind(to: viewModel.input.showHolidayButton)
            .disposed(by: disposeBag)
        
        selectButton.rx.tap
            .bind(to: viewModel.input.selectButton)
            .disposed(by: disposeBag)
    }
    
    private func bindData() {
        viewModel.output.selectedCountry
            .map({ return "\($0.code) - \($0.name)"})
            .drive( countryLabel.rx.text )
            .disposed(by: disposeBag)
        
        /// Hidden CountryLabel when don't select any country
        viewModel.output.selectedCountry
            .map({ return $0.name.isEmpty })
            .drive( countryLabel.rx.isHidden )
            .disposed(by: disposeBag)
        
        /// Enable Show Holiday Button  when don't select any country
        viewModel.output.selectedCountry
            .map({ return !$0.name.isEmpty })
            .drive( showHolidayButton.rx.isEnabled )
            .disposed(by: disposeBag)
    }
}
