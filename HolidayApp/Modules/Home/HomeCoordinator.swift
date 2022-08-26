//
//  HomeCoordinator.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 19/08/2022.
//

import Foundation
import RxSwift
import UIKit

class HomeCoordinator: BaseCoordinator<Void>,  InitialCoordinator {
    private let rootViewController: UIViewController
    
    required init(rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    override func start() -> Observable<Void> {
        let viewController = rootViewController as! HomeViewController
        let viewModel = viewController.viewModel!
        
       viewModel.output.selectButton
            .flatMapLatest{ [weak self]_ -> Observable<SearchCountryResult> in
                guard let `self` = self else {return .empty() }
                return self.searchCountryView()
            }.map{ result in
                switch result {
                case .country(let country): return country
                }
            }.bind(to: viewModel.input.selectedCountry.asObserver())
            .disposed(by: disposeBag)
        
        return Observable.never()
    }
}

extension HomeCoordinator {
    private func searchCountryView() -> Observable<SearchCountryResult> {
        let coordinator = SearchCountryCoordinator(rootViewController: rootViewController)
        return coordinate(to: coordinator)
    }
    
}
