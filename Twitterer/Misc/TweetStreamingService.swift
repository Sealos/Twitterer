//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

import Foundation

/// Protocols for the services, required for the Delegation pattern and the Mocking

protocol TweetStreamingServiceDelegate: class {
    func twitterService(didRecieveTweet tweet: Tweet)
    func twitterService(didRecieveError error: Error)
}

protocol TweetStreamingService: class {
    var delegate: TweetStreamingServiceDelegate? { get set }
    func startStreamingTweets()
}
