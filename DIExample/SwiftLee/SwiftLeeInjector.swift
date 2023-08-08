import Foundation

@propertyWrapper
struct SwiftLeeInject<T> {

    private let keyPath: WritableKeyPath<SwiftLeeContainer, T>

    var wrappedValue: T {
        get { SwiftLeeContainer[keyPath] }
        set { SwiftLeeContainer[keyPath] = newValue }
    }

    init(_ keyPath: WritableKeyPath<SwiftLeeContainer, T>) {
        self.keyPath = keyPath
    }
}
