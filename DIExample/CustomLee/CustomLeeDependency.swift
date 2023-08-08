import Foundation

enum CustomLeeDependency {
    static func configure() {
        let container = CustomLeeContainer.shared
        container.fooRepository = FooRepositoryImpl()
        container.fooUseCase = CustomLeeUseCase()
    }
}
