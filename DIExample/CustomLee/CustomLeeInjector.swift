import Foundation

@propertyWrapper
struct CustomLeeInject<T> {

    private let keyPath: WritableKeyPath<CustomLeeContainer, T?>

    var wrappedValue: T {
        get { CustomLeeContainer.shared[keyPath: keyPath]! }
        set { CustomLeeContainer.shared[keyPath: keyPath] = newValue }
    }

    init(_ keyPath: WritableKeyPath<CustomLeeContainer, T?>) {
        self.keyPath = keyPath
    }
}
