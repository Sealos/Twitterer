//
//  Copyright © 2017 Stefano De Colli. All rights reserved.
//

import UIKit

extension UITableViewCell: ReusableView { }
extension UITableViewCell: NibLoadableView { }

extension UITableView {
    /// Dequeue a reusable view with an identifier that has the same name of the class
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }

    /// Dequeue a reusable view with an identifier that has the same name of the class
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }

    /// Registers a class and a nib with the same name in the tableView
    /// A .xib with the same name of the class must exists, otherwise it will crash
    func register<T: UITableViewCell>(_: T.Type) {

        let nib = UINib(nibName: T.nibName, bundle: Bundle.main)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
}
