import Foundation
import Swinject

enum SwinjectContainer {
    static private var container = Container()

    static func initialize() {
        container.register(FooRepository.self) { _ in FooRepositoryImpl() }
        container.register(FooUseCase.self) { r in
            SwinjectUseCase(fooRepository: r.resolve(FooRepository.self)!)
        }
    }

    static func resolve<Service>(_ serviceType: Service.Type) -> Service {
        container.resolve(serviceType)!
    }
}
