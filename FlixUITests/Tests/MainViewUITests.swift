//
//  MainViewUITests.swift
//  FlixUITests
//
//  Created by Matt on 04/04/2022.
//

import Foundation
import XCTest

class MainViewTests: XCTestCase {
    func testNavigation_userMovesToDetails_AfterTapOnCell() {
        AppRobot()
            .launchApp()
            .isExampleCellShowing()
            .tapExampleCell()
            .isExampleCellShowing()
    }
}
