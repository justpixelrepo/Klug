import Foundation

public class Bindable<T> {
    public private(set) var value: T {
        didSet {
            valueChanged?(value)
        }
    }

    private var valueChanged: ((T) -> Void)?

    public init(_ value: T) {
        self.value = value
    }

    public func bind(_ valueChanged: ((T) -> Void)?) {
        self.valueChanged = valueChanged
    }

    public func bindAndApply(_ valueChanged: ((T) -> Void)?) {
        self.valueChanged = valueChanged
        valueChanged?(value)
    }

    public func unbind() {
        valueChanged = nil
    }

    public func update(_ value: T) {
        self.value = value
    }

    public func update(block: (inout T) -> Void) {
        var value = self.value
        block(&value)
        self.value = value
    }
}
