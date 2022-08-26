//
//  SearchCountryCoordinator.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 23/08/2022.
//

import Foundation
import UIKit
import RxSwift

enum SearchCountryResult {
    case country(country: Country)
}

class SearchCountryCoordinator: BaseCoordinator<SearchCountryResult>, InitialCoordinator {
    private var rootViewController: UIViewController

    
    required init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<SearchCountryResult> {
        let viewModel = SearchCountryViewModel()
        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchCountryViewController") as! SearchCountryViewController
        viewController.viewModel = viewModel
        
        rootViewController.navigationController?.pushViewController(viewController, animated: true)
        
        let coordinatorResult = viewModel.output.selectedCountry
            .map{ SearchCountryResult.country(country: $0) }
        
        return coordinatorResult
            .take(1)
            .do(onNext: { [weak self] _ in
                self?.rootViewController.navigationController?.popViewController(animated: true)
            })
    }
    
}
