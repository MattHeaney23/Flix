//
//  AppRobot.swift
//  FlixUITests
//
//  Created by Matt on 04/04/2022.
//

import Foundation
import XCTest

class AppRobot: Robot {
    
    @discardableResult
    func launchApp() -> MainViewRobot {
        app.launch()
        return MainViewRobot()
    }
    
}
