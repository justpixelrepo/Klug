import UIKit

/// A navigation controller that logs its deinitialization when running in Debug mode.
open class CoordinatedNavigationController: UINavigationController {
    // MARK: - View Controller Life Cycle

    deinit {
        #if DEBUG
        print("🎈 \(String(describing: self)) deinitialized.")
        #endif
    }
}
