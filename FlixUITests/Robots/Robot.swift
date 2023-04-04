//
//  Robot.swift
//  FlixUITests
//
//  Created by Matt on 04/04/2022.
//

import Foundation
import XCTest

protocol Robot {}

extension Robot {
    var app: XCUIApplication {
        XCUIApplication()
    }
}
