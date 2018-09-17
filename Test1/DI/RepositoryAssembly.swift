//
//  RepositoryAssembly.swift
//  Test1
//
//  Created by Primeholding Template.
//  Copyright © 2018 Primeholding. All rights reserved.
//

import Foundation
import Swinject

class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(DetailsRepository.self, initializer: DetailsRepository.init)
    }
}
