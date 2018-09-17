//
//  DetailsViewModel.swift
//  Test1
//
//  Created by Primeholding on 13.09.18.
//  Copyright © 2018 Primeholding. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Protocols
protocol DetailsViewModelInput: class {
    func fetch()
}

protocol DetailsViewModelOutput {
    var details: Driver<String> { get }
    var isLoading: Driver<Bool> { get }
}

protocol DetailsViewModelType {
    var input: DetailsViewModelInput { get }
    var output: DetailsViewModelOutput { get }
}

// MARK: - View Model Implementaion
class DetailsViewModel: DetailsViewModelInput, DetailsViewModelOutput, DetailsViewModelType {

    // MARK: Outputs
    let details: Driver<String>
    var isLoading: Driver<Bool> {
        return self.loadingViewModel.isLoading.asDriver(onErrorJustReturn: false)
    }

    // MARK: Internaly used
    private let loadingViewModel: LoadingViewModel

    // MARK: Initialization
    init(repo: DetailsRepository) {

        let dataRequest = fetchSubject
            .flatMapLatest { repo.fetch() }
            .share(replay: 1)

        details = dataRequest
            .whenSuccess()
            .startWith("")
            .asDriver(onErrorJustReturn: "")

        loadingViewModel = LoadingViewModel([
            dataRequest.isLoading()
        ])
    }

    // MARK: Inputs
    private let fetchSubject = PublishRelay<Void>()
    func fetch() {
        fetchSubject.accept(())
    }

    // MARK: InputOutput
    var input: DetailsViewModelInput { return self }
    var output: DetailsViewModelOutput { return self }
}

// MARK: - Custom Operators
