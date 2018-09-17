//
//  CommonAssembly.swift
//  Test1
//
//  Created by Primeholding Template.
//  Copyright © 2018 Primeholding. All rights reserved.
//

import Foundation
import Swinject

class CommonAssembly: Assembly {
    func assemble(container: Container) {
        registerUserDefaults(into: container)
    }
}

// MARK: - User Defaults
private extension CommonAssembly {

    func registerUserDefaults(into container: Container) {
        container
            .register(UserDefaults.self) { _ in UserDefaults.standard }
            .singleton()
    }
}
