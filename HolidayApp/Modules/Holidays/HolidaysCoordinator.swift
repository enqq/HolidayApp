//
//  HolidaysCoordinator.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 26/08/2022.
//

import Foundation
import UIKit
import RxSwift

class HolidaysCoordinator: BaseCoordinator<Void> ,InitialCoordinator {
    private let rootViewController: UIViewController
    var viewModel: HolidaysViewModel!
    
    required init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController =  storyboard.instantiateViewController(withIdentifier: "HolidaysViewController") as! HolidaysViewController
        
        viewController.viewModel = viewModel
        
        rootViewController.navigationController?.show(viewController, sender: nil)
        return Observable.empty()
    }
}
// MARK: Navigation
extension HolidaysCoordinator {
    private func detailsHolidayView() {
        
    }
}
