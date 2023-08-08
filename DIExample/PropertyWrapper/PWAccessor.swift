import Foundation

@propertyWrapper
public struct Inject<T> {

    private let keyPath: WritableKeyPath<PWContainer, T>

    public var wrappedValue: T {
        get { PWContainer[keyPath] }
        set { PWContainer[keyPath] = newValue }
    }

    init(_ keyPath: WritableKeyPath<PWContainer, T>) {
        self.keyPath = keyPath
    }
}
