//
//  CounterViewModel.swift
//  Test1
//
//  Created by Primeholding Template.
//  Copyright © 2018 Primeholding. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Protocols
protocol CounterViewModelInput: class {
    func increment()
    func decrement()
}

protocol CounterViewModelOutput {
    var count: Driver<String> { get  }
}

protocol CounterViewModelType {
    var input: CounterViewModelInput { get }
    var output: CounterViewModelOutput { get }
}

// MARK: - View Model Implementaion
class CounterViewModel: CounterViewModelInput, CounterViewModelOutput, CounterViewModelType {
    // MARK: Outputs
    let count: Driver<String>

    // MARK: Locally used subjects
    let countSubject = BehaviorRelay(value: 0)
    let disposeBag = DisposeBag()

    // MARK: Initialization
    init() {
        Observable
            .merge(
                incrementSubject.increment(value: countSubject),
                decrementSubject.decrement(value: countSubject)
            )
            .bind(to: countSubject)
            .disposed(by: disposeBag)

        count = countSubject
            .format()
            .asDriver(onErrorJustReturn: "")
    }

    // MARK: Inputs
    private let incrementSubject = PublishRelay<Void>()
    func increment() {
        incrementSubject.accept(())
    }

    private let decrementSubject = PublishRelay<Void>()
    func decrement() {
        decrementSubject.accept(())
    }

    // MARK: InputOutput
    var input: CounterViewModelInput { return self }
    var output: CounterViewModelOutput { return self }
}

// MARK: - Custom Operators
fileprivate extension ObservableType where Self.E == Int {

    /// Format to specific string format
    ///
    /// - Returns: Formatted stirng
    func format() -> Observable<String> {
        return map { "Current count is \($0)" }
    }
}

fileprivate extension ObservableType where Self.E == Void {

    /// Increment the given value
    ///
    /// - Parameter value: Value that will be used for incrementing
    /// - Returns: Observable of incremented value
    func increment(value: BehaviorRelay<Int>) -> Observable<Int> {
        return map { value.value + 1 }
    }

    /// Decrement the give value
    ///
    /// - Parameter value: Value that will be used for decrementing
    /// - Returns: Observable of decremented value
    func decrement(value: BehaviorRelay<Int>) -> Observable<Int> {
        return map { value.value - 1 }
    }
}
