//
//  DIContainer.swift
//
//  Created by Primeholding Template
//  Copyright © 2018 Primeholding. All rights reserved.
//

import Foundation
import UIKit
import Swinject

protocol DIContainer: class {
    static var container: Container { get }
    static func createContainer() -> Container
}

extension DIContainer where Self: AppDelegate {

    static func createContainer() -> Container {
        Container.loggingFunction = nil

        let container = Container()

        _ = Assembler(
            [
                ViewModelAssembly(),
                ViewControllerAssembly(),
                RepositoryAssembly(),
                ServiceAssembly(),
                CommonAssembly()
            ],
            container: container
        )

        return container
    }
}
