//
//  HolidaysCoordinator.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 26/08/2022.
//

import Foundation
import UIKit
import RxSwift

class HolidaysCoordinator: BaseCoordinator<Void>, InitialCoordinator {
    private let rootViewController: UIViewController
    var viewModel: HolidaysViewModel!
    
    required init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController =  storyboard.instantiateViewController(withIdentifier: "HolidaysViewController") as! HolidaysViewController
        
        viewController.viewModel = viewModel
        
        viewModel.output.selectedHoliday
            .subscribe(onNext: { [weak self] holiday in
               _ = self?.detailsHolidayView(holiday)
            })
            .disposed(by: disposeBag)
        
        rootViewController.navigationController?.show(viewController, sender: nil)
        return Observable.never()
    }
}
// MARK: Navigation
extension HolidaysCoordinator {
    private func detailsHolidayView(_ holiday: Holiday) -> Observable<Void> {
        let viewModel = DetailsHolidayViewModel(holiday: holiday)
        let coordinator = DetailsHolidayCoordinator.init(rootViewController: rootViewController)
        coordinator.viewModel = viewModel
      
        return coordinate(to: coordinator)
    }
}
