import Foundation

enum SwiftLeeDependency {
    static func configure() {
        FooRepositoryStore.currentValue = FooRepositoryImpl()
        FooUseCaseStore.currentValue = SwiftLeeUseCase()
    }
}
