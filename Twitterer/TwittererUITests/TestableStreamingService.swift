//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

import UIKit
import Foundation

class TestableStreamingService: TweetStreamingService {
    weak var delegate: TweetStreamingServiceDelegate?
    var timer = Timer()

    func startStreamingTweets() {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: postTweet)
    }

    func postTweet(_ timer: Timer) {
        let tweet = Tweet()
        delegate?.twitterService(didRecieveTweet: tweet)
    }
}
