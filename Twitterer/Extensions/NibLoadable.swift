//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

import UIKit

protocol NibLoadableView: class { }

extension NibLoadableView where Self: UIView {

    static var nibName: String {
        return String(describing: self)
    }

    /// Instantiates a view from a xib, will default to the class name
    static func instantiateFromNib() -> Self {
        #if UITEST
            let bundle = Bundle(for: TestableStreamingService.self)
        #else
            let bundle = Bundle.main
        #endif

        guard let view = bundle.loadNibNamed(nibName, owner: nil, options: nil)?.first as? Self else {
            fatalError("Could not instantiate nib: \(nibName)")
        }
        return view
    }
}

protocol ReusableView: class {}

extension ReusableView where Self: UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
