//
//  DetailsHolidayViewController.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 02/09/2022.
//

import UIKit
import RxSwift

class DetailsHolidayViewController: UIViewController {
    
    /// Depedencies
    var viewModel: DetailsHolidayViewModel!
    let diposeBag = DisposeBag()
    
    /// Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var observedLabel: UILabel!
    @IBOutlet weak var observedWeekdayLabel: UILabel!
    
    /// Lifecycyles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        
        bindData()
    }
}
// MARK: Setup View
extension DetailsHolidayViewController {
    private func setupView() {
        self.title = "Holiday"
    }
}

// MARK: Bind Data
extension DetailsHolidayViewController {
    private func bindData() {
        viewModel.output.holiday
            .map({ $0.name })
            .map({ "Name: \($0)"})
            .drive(nameLabel.rx.text)
            .disposed(by: diposeBag)
        
        viewModel.output.holiday
            .map{ $0.country }
            .map({ "Country: \($0)"})
            .drive(countryLabel.rx.text)
            .disposed(by: diposeBag)
        
        viewModel.output.holiday
            .map({ $0.date })
            .map({ "Date: \($0)"})
            .drive(dateLabel.rx.text)
            .disposed(by: diposeBag)
        
        viewModel.output.holiday
            .map{ $0.weekday }
            .map({ "Day \($0.name) - Number \($0.numeric)"})
            .drive(weekdayLabel.rx.text)
            .disposed(by: diposeBag)
        
        viewModel.output.holiday
            .map({ $0.observed })
            .map({ "Observed: \($0)" })
            .drive(observedLabel.rx.text)
            .disposed(by: diposeBag)
        
        viewModel.output.holiday
            .map({ $0.weekdayObserved })
            .map({ "Day \($0.name) - Number \($0.numeric)"})
            .drive(observedWeekdayLabel.rx.text)
            .disposed(by: diposeBag)
        
    }
}
