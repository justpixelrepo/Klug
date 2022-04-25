import UIKit
import SwiftUI

public struct UIViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
    let viewController: ViewController
    
    func updateUIViewController(context: Context) -> ViewController {
        return ViewController.init()
    }

    init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }

    // MARK: - UIViewControllerRepresentable
    public func makeUIViewController(context: Context) -> ViewController {
        viewController
    }
    
    public func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}

public struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    // MARK: UIViewRepresentable
    public func makeUIView(context: Context) -> UIView {
        return view
    }
    
    public func updateUIView(_ view: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}

extension PreviewDevice: Hashable {
    public static let selected: [PreviewDevice] = [.init(stringLiteral: "iPhone 13 Mini"),
                                              .init(stringLiteral: "iPhone 13"),
                                              .init(stringLiteral: "iPhone 13 Pro Max")]
}


public extension ContentSizeCategory {
    static let sizes: [ContentSizeCategory] = [.extraSmall, .large, .accessibilityExtraExtraExtraLarge]
}



