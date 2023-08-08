import Foundation

enum SimpleDependency {
    static func configure() {
        let fooRepository = FooRepositoryImpl()
        let fooUseCase = SimpleUseCase(fooRepository: fooRepository)

        SimpleContainer.shared = SimpleContainer(
            fooRepository: fooRepository,
            fooUseCase: fooUseCase
        )
    }
}
