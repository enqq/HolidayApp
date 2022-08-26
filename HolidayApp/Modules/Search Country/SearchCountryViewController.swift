//
//  SearchCountryViewController.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 23/08/2022.
//

import UIKit
import RxSwift
import RxCocoa

class SearchCountryViewController: UIViewController {

    /// Depedencies
    var viewModel: SearchCountryViewModel!
    let disposeBag = DisposeBag()
    
    /// Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private var activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPage()
        setupView()
        registerCell()
        
        bindTabelView()
        bindData()
    }
}

// MARK: Setup View
extension SearchCountryViewController {
    private func setupView() {
        self.title = "Search Country"
        
    }
    
    /// Shows activity indicator when fetch data
    /// Hidden activity indicator in function bindTableView()
    func loadPage() {
        activityIndicator.frame = UIScreen.main.bounds
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func registerCell() {
        let cell = UINib(nibName: "CountryTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "countryCell")
    }
}

// MARK: Bind data
extension SearchCountryViewController {
    private func bindTabelView() {
        /// Load data to TableView
        viewModel.output.countries
            .do(onNext: { [weak self] _ in
                /// Hidden activity indicator when fetch data complete
                self?.activityIndicator.stopAnimating()
            })
            .drive(tableView.rx.items(cellIdentifier: "countryCell", cellType: CountryTableViewCell.self)) { (_, country, cell) in
                cell.setCountry(country.code, country.name)
            }
            .disposed(by: disposeBag)
        
        /// Taped row in TableView
        tableView.rx.modelSelected(Country.self)
            .bind(to: viewModel.input.selectedCountry)
            .disposed(by: disposeBag)
    }
    
    private func bindData() {
        searchBar.rx.text
            .orEmpty
            .bind(to: viewModel.input.searchText)
            .disposed(by: disposeBag)
        
        
    }
}
