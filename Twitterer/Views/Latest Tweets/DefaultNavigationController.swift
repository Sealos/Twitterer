//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

import Foundation
import UIKit

class DefaultNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyle()
    }

    private func configureStyle() {
        navigationBar.barTintColor = .red
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
