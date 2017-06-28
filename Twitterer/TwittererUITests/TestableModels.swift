//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

import Foundation

extension TwitterUser {
    init() {
        self.accountName = "sdecolli"
        self.name = "Stefano"
        self.profileImageURL = URL(string: "https://pbs.twimg.com/profile_images/836594118692319232/Fv3fovF__bigger.jpg")!
    }
}

extension Tweet {
    init() {
        self.text = "Testable tweet"
        self.user = TwitterUser()
    }
}
