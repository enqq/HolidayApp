//
//  AppCoordinator.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 19/08/2022.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    var window: UIWindow
    
    init(window: UIWindow){
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        viewController.viewModel = HomeViewModel()
        
        let navigationController = UINavigationController.init(rootViewController: viewController)
        let coordinator = HomeCoordinator(rootViewController: navigationController.viewControllers[0])
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return coordinate(to: coordinator)
    }
}
