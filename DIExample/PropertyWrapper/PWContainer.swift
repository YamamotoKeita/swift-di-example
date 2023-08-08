import Foundation

public protocol InjectionKey {
    associatedtype Value
    static var currentValue: Self.Value { get set }
}

struct PWContainer {
    private static var shared = PWContainer()

    var fooRepository: FooRepository

    init() {
        fooRepository = FooRepositoryImpl()
    }

    static subscript<K>(key: K.Type) -> K.Value where K : InjectionKey {
        get { key.currentValue }
        set { key.currentValue = newValue }
    }

    static subscript<T>(_ keyPath: WritableKeyPath<PWContainer, T>) -> T {
        get { shared[keyPath: keyPath] }
        set { shared[keyPath: keyPath] = newValue }
    }
}

struct FooRepositoryKey: InjectionKey {
    typealias Value = FooRepository
    static var currentValue: FooRepository = FooRepositoryImpl()
}
