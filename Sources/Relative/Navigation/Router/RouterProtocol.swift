import UIKit

/// The protocol required by the `RouterProtocol` as its input type.
public protocol Presentable {
    var viewController: UIViewController? { get }
}

/// The protocol to which all routers implicitly conform.
public protocol RouterProtocol: AnyObject {
    var navigationController: UINavigationController { get }

    func hideBar()
    func showBar()
    func push(_ presentable: Presentable, isAnimated: Bool)
    func push(_ presentable: Presentable, isAnimated: Bool, onNavigateBack: (() -> Void)?)
    func pop(_ isAnimated: Bool)
    func setRootController(_ presentable: Presentable?, hideBar: Bool)
    func popToRootController(animated: Bool)
    func present(_ presentable: Presentable, isAnimated: Bool)
    func present(_ presentable: Presentable, isAnimated: Bool, onDismiss closure: (() -> Void)?)
    func dismiss(_ animated: Bool)
    func dismiss(_ animated: Bool, completion: (() -> Void)?)
}
