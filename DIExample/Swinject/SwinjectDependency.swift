import Swinject

enum SwinjectDependency {
    static func configure() {
        let container = SwinjectContainer.shared
        container.register(FooRepository.self) { _ in FooRepositoryImpl() }
        container.register(FooUseCase.self) { r in
            SwinjectUseCase(fooRepository: r.resolve(FooRepository.self)!)
        }
    }
}
