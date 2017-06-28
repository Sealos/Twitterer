//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

import Foundation

/// Data structures to display Twitter users
struct TwitterUser {
    let name: String
    let accountName: String
    let profileImageURL: URL

    init?(json: JSON) {
        guard let name = json["name"].string else { return nil }
        guard let accountName = json["screen_name"].string else { return nil }
        guard let profileImageURLString = json["profile_image_url_https"].string else { return nil }
        guard let profileImageURL = URL(string: profileImageURLString) else { return nil }

        self.name = name
        self.accountName = accountName
        self.profileImageURL = profileImageURL
    }
}

/// Data structures to display Twitter tweets
struct Tweet {
    let text: String
    let user: TwitterUser

    init?(json: JSON) {
        guard let user = TwitterUser(json: json["user"]) else { return nil }
        guard let text = json["text"].string else { return nil }

        self.user = user
        self.text = text
    }
}
