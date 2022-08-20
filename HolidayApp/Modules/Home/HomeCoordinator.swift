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
        return Observable.never()
    }
    
}
