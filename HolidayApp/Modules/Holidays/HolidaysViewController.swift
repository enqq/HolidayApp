//
//  HolidaysViewController.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 26/08/2022.
//

import UIKit
import RxSwift
import RxCocoa

class HolidaysViewController: UIViewController {

    /// Depedencies
    var viewModel: HolidaysViewModel!
    private let disposeBag = DisposeBag()
    
    /// Properties
    @IBOutlet weak var tableView: UITableView!
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    /// Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        loadPage()
        setupView()
        registerCell()

        bindTableView()
    }
}

// MARK: Setup View
extension HolidaysViewController {
    private func setupView() {
        self.title = "Holidays"
    }
    
    /// Shows activity indicator when fetch data
    /// Hidden activity indicator in function bindTableView()
    private func loadPage() {
        activityIndicator.frame = UIScreen.main.bounds
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
       
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "HolidayTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "holidayCell")
    }
}

// MARK: Bind Data
extension HolidaysViewController {
    private func bindTableView() {
        viewModel.output.holidays
            .do(onNext: { [weak self] _ in
                /// Hidden activity indicator when fetch data complete
                self?.activityIndicator.stopAnimating()
            })
            .drive(tableView.rx.items(cellIdentifier: "holidayCell", cellType: HolidayTableViewCell.self)) { (_, holiday, cell) in
                cell.setCell(name: holiday.name, date: holiday.date)
            }
            .disposed(by: disposeBag)
        
        ///Taped row in table
        tableView.rx.modelSelected(Holiday.self)
            .do(onNext: { [weak self] _ in
                /// Deselect cell
                self?.tableView.selectRow(at: nil, animated: true, scrollPosition: UITableView.ScrollPosition.none)
            })
            .bind(to: viewModel.input.selectedHoliday)
            .disposed(by: disposeBag)
        
    }
}
