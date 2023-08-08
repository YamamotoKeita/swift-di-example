import Foundation

struct SwiftLeeContainer {
    private static var current = SwiftLeeContainer()

    static subscript<T>(_ keyPath: WritableKeyPath<SwiftLeeContainer, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }

    var fooRepository: FooRepository {
        get { FooRepositoryStore.currentValue }
        set { FooRepositoryStore.currentValue = newValue }
    }

    var fooUseCase: FooUseCase {
        get { FooUseCaseStore.currentValue }
        set { FooUseCaseStore.currentValue = newValue }
    }
}

protocol ValueStore {
    associatedtype Value
    static var currentValue: Self.Value { get set }
}

struct FooRepositoryStore: ValueStore {
    static var currentValue: FooRepository = FooRepositoryImpl()
}

struct FooUseCaseStore: ValueStore {
    static var currentValue: FooUseCase = SwiftLeeUseCase()
}
