//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

import UIKit

class LatestTweetHeader: UIView {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var label: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()

        frame.size.height = 53
    }
}

extension LatestTweetHeader: NibLoadableView {}
