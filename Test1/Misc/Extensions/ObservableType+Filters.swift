//
//  ObservableType+Filters.swift
//  Test1
//
//  Created by Georgi Stanev on 17.09.18.
//  Copyright © 2018 Georgi Stanev. All rights reserved.
//

import Foundation
import RxSwift
import RxOptional

// MARK: - Default unwrapped implementation
extension ObservableType {

    func whenSuccess<T>() -> Observable<T> where Self.E == ApiResult<T> {
        return map { $0.getSuccess() }
            .filterNil()
    }

    func whenError<T>() -> Observable<ApiError> where Self.E == ApiResult<T> {
        return map { $0.getError() }
            .filterNil()
    }

    func isLoading<T>() -> Observable<Bool> where Self.E == ApiResult<T> {
        return map { $0.isLoading }
    }
}
