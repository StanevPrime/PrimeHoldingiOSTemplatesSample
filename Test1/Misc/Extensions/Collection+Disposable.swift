//
//  Collection+Disposable.swift
//  Test1
//
//  Created by Primeholding Template.
//  Copyright © 2018 Primeholding. All rights reserved.
//

import Foundation
import RxSwift

extension Collection where Self.Element == Disposable {
    func disposed(by disposeBag: DisposeBag) {
        forEach { $0.disposed(by: disposeBag) }
    }
}
