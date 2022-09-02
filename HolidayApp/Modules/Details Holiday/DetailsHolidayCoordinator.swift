//
//  DetailsHolidayCoordinator.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 02/09/2022.
//

import Foundation
import UIKit
import RxSwift

class DetailsHolidayCoordinator: BaseCoordinator<Void>, InitialCoordinator {
    private var rootViewController: UIViewController
    var viewModel: DetailsHolidayViewModel!
    
    required init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailsHolidayViewController") as! DetailsHolidayViewController
        viewController.viewModel = viewModel
        
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
        return Observable.never()
    }
    
}
