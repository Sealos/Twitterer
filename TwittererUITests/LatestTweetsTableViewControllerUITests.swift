//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

import XCTest

/// View controller logic test
/// Views are loaded by nibs, and set to the application
/// Some conditional compilation is required (See: UITEST)
/// However, this can be removed if no UI views are needed on the LatestTweetsTableViewController
class LatestTweetsTableViewControllerUITests: XCTestCase {

    var latestTweetVC: LatestTweetsTableViewController!

    override func setUp() {
        super.setUp()

        let mockService = TestableStreamingService()
        latestTweetVC = LatestTweetsTableViewController(service: mockService)
        mockService.startStreamingTweets()

        _ = latestTweetVC.loadViewIfNeeded()
    }

    func testViewControllerExists() {
        XCTAssertNotNil(latestTweetVC.view, "Should contain a view")
    }

    func testViewControllerRecievedTweets() {
        latestTweetVC.twitterService(didRecieveTweet: Tweet())
        XCTAssert(latestTweetVC.buffer.array.count > 0)
    }

    func testNavigationItem() {
        XCTAssert(latestTweetVC.navigationItem.title == "Twitterer")
    }
}
