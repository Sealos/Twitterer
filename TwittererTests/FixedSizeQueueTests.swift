//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

import XCTest
@testable import Twitterer

class FixedSizeQueueTests: XCTestCase {

    func testFixedQueue() {
        let queue = Twitterer.FixedSizeQueue<Int>(maxSize: 5)

        XCTAssert(queue.values == [])
    }

    func testFixedQueueInsertionLessMaxSize() {
        var queue = Twitterer.FixedSizeQueue<Int>(maxSize: 5)

        for i in 0 ..< 3 {
            queue.enqueue(i)
        }

        XCTAssert(queue.values == [2, 1, 0])
    }

    func testFixedQueueInsertionMaxSize() {
        var queue = Twitterer.FixedSizeQueue<Int>(maxSize: 5)

        for i in 0 ..< 5 {
            queue.enqueue(i)
        }

        XCTAssert(queue.values == [4, 3, 2, 1, 0])
    }

    func testFixedQueueInsertionMaxPlusOne() {
        var queue = Twitterer.FixedSizeQueue<Int>(maxSize: 5)

        for i in 0 ..< 5 {
            queue.enqueue(i)
        }

        queue.enqueue(5)

        XCTAssert(queue.values == [5, 4, 3, 2, 1])
    }

    func testFixedQueueInsertionOverride() {
        var queue = Twitterer.FixedSizeQueue<Int>(maxSize: 5)

        for i in 0 ..< 20 {
            queue.enqueue(i)
        }

        XCTAssert(queue.values == [19, 18, 17, 16, 15])
    }
}
