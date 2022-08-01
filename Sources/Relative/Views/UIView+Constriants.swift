import Foundation
import UIKit

public extension UIView {
    func pin(to view: UIView, insets: UIEdgeInsets = .zero) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -insets.right),
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -insets.bottom)
        ])
    }

    func pinToSuperview(withInsets insets: UIEdgeInsets = UIEdgeInsets()) {
        guard let superview = superview else {
            return
        }

        pin(to: superview, insets: insets)
    }
}
