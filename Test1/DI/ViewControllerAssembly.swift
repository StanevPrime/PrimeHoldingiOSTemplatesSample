//
//  ViewControllerAssembly.swift
//  Test1
//
//  Created by Primeholding Template.
//  Copyright © 2018 Primeholding. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class ViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        registerCounter(into: container)
        registerDetails(into: container)
    }
}

private extension ViewControllerAssembly {
    func registerCounter(into container: Container) {
        container.storyboardInitCompleted(CounterViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(CounterViewModel.self)!
        }
    }

    func registerDetails(into container: Container) {
        container.storyboardInitCompleted(DetailsViewController.self) { resolver, controller in
            controller.viewModel = resolver.resolve(DetailsViewModel.self)!
        }
    }
}
