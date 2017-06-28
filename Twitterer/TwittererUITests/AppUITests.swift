//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

import XCTest

class AppUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        app = XCUIApplication()
        app.launch()
    }

    func testAppLaunch() {
        XCTAssert(app.staticTexts["Twitterer"].exists)
    }

    func testStreaming() {
        sleep(5)

        XCTAssert(app.staticTexts["Testable tweet"].exists)
    }
}
