//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

/// Twitter stream service implemented using Swifter
class TwitterService: TweetStreamingService {

    private var request: HTTPRequest?

    lazy private var swifter: Swifter = {
        let client = Swifter(consumerKey: Constants.Twitter.key, consumerSecret: Constants.Twitter.secret, oauthToken: Constants.Twitter.accessToken, oauthTokenSecret: Constants.Twitter.accessTokenSecret)

        return client
    }()

    weak var delegate: TweetStreamingServiceDelegate?

    func startStreamingTweets() {
        request?.stop()

        request = swifter.postTweetFilters(track: ["sweden"], progress: tweetRecieved, failure: errorHandler)
    }

    private func tweetRecieved(json: JSON) {
        if let tweet = Tweet(json: json) {
            delegate?.twitterService(didRecieveTweet: tweet)
        }
    }

    private func errorHandler(error: Error) {
        delegate?.twitterService(didRecieveError: error)
    }
}
