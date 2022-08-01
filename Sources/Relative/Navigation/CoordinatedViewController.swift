import UIKit

/// The interface to be implemented by a class managed by a coodinator.
public protocol Actionable: AnyObject, Presentable {}

/// A view controller that logs its deinitialization when running in Debug mode.
open class CoordinatedViewController: UIViewController, Actionable {
    public var viewController: UIViewController?
    
    // MARK: - View Controller Life Cycle

    deinit {
        #if DEBUG
        print("🎈 \(String(describing: self)) deinitialized.")
        #endif
    }
}
