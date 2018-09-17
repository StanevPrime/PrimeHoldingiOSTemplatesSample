//
//  Swinject+Extensions.swift
//  Test1
//
//  Created by Primeholding Template.
//  Copyright © 2018 Primeholding. All rights reserved.
//

import Foundation
import Swinject

extension ServiceEntry {
    func singleton() {
        inObjectScope(.container)
    }
}
