//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

import Foundation
import UIKit

class TweetTableViewCell: UITableViewCell {
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var userDisplayName: UILabel!
    @IBOutlet private weak var tweetDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = userImage.frame.width / 2
        selectionStyle = .none
    }

    /// Customizes a TweetTableViewCell for s specific tweet
    func customize(with tweet: Tweet) {
        tweetDescription.text = tweet.text

        userDisplayName.attributedText = TweetTableViewCell.userDisplayName(tweet: tweet)

        URLSession.shared.dataTask(with: tweet.user.profileImageURL) { data, response, error in
            self.userImage.image = data.flatMap(UIImage.init(data:))
        }
    }

    /// Joins the user name with his account name, using different styles to resemble the twitter look
    private static func userDisplayName(tweet: Tweet) -> NSAttributedString {

        let nameAtributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 14),
            .foregroundColor: UIColor.black
        ]

        let nameString = NSMutableAttributedString(string: tweet.user.name, attributes: nameAtributes)

        let accountNameAtributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.darkGray
        ]

        let accountString = NSAttributedString(string: " @\(tweet.user.accountName)", attributes: accountNameAtributes)

        nameString.append(accountString)

        return nameString
    }
}
