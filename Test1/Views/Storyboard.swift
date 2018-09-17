//
//  Storyboard.swift
//  Test1
//
//  Created by Primeholding Template.
//  Copyright © 2018 Primeholding. All rights reserved.
//

import Foundation
import UIKit
import SwinjectStoryboard

enum Storyboard: String {

    case main = "Main"

    func instantiate<VC: UIViewController>(_ viewController: VC.Type, inBundle bundle: Bundle? = nil) -> VC {
        guard let viewController = SwinjectStoryboard
            .create(name: self.rawValue, bundle: bundle, container: AppDelegate.container)
            .instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC
        else {
            fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(self.rawValue) storyboard")
        }

        return viewController
    }

    func instantiate(_ viewController: String, inBundle bundle: Bundle? = nil) -> UIViewController? {
        return SwinjectStoryboard
                .create(name: rawValue, bundle: bundle, container: AppDelegate.container)
                .instantiateViewController(withIdentifier: viewController)
    }

    func initialViewController() -> UIViewController? {
        return SwinjectStoryboard
            .create(name: self.rawValue, bundle: nil, container: AppDelegate.container)
            .instantiateInitialViewController()
    }
}
