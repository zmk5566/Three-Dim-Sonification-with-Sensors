//
//  Three_Dim_Sonification_with_SensorsUITestsLaunchTests.swift
//  Three Dim Sonification with SensorsUITests
//
//  Created by k on 2/10/2022.
//

import XCTest

final class Three_Dim_Sonification_with_SensorsUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
