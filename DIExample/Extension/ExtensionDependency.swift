import Foundation

enum ExtensionDependency {
    static func configure() {
        let fooRepository = FooRepositoryImpl()
        let fooUseCase = ExtensionUseCase()
        ExtensionContainer.shared = ExtensionContainer(
            fooRepository: fooRepository,
            fooUseCase: fooUseCase
        )
    }
}
