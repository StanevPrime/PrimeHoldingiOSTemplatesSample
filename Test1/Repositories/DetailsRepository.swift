//
//  DetailsRepository.swift
//  Test1
//
//  Created by Primeholding Template. on 13.09.18.
//  Copyright © 2018 Primeholding. All rights reserved.
//

import Foundation
import RxSwift

class DetailsRepository {

    func fetch() -> Observable<ApiResult<String>> {
        return Observable<Int>
            .timer(20, scheduler: MainScheduler.asyncInstance)
            .take(1)
            .map { _ in "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat." }
            .map { .success(withData: $0) }
            .startWith(.loading)
    }
}
