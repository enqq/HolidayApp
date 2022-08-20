//
//  BaseCoordinator.swift
//  HolidayApp
//
//  Created by Dawid Karpiński on 19/08/2022.
//

import RxSwift

open class BaseCoordinator<ResultType>: NSObject {

    public typealias CoordinationResult = ResultType
    
    public let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    
    public let disposeBag = DisposeBag()
    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]()

    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }

    private func release<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }

    @discardableResult
    open func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in
                self?.release(coordinator: coordinator) })
    }

    open func start() -> Observable<ResultType> {
        fatalError("start() method must be implemented")
    }
}
