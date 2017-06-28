//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        #if UITEST
            let service = TestableStreamingService()
        #else
            let service = TwitterService()
        #endif

        let latestTweetVC = LatestTweetsTableViewController(service: service)

        let navigationController = DefaultNavigationController(rootViewController: latestTweetVC)

        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
