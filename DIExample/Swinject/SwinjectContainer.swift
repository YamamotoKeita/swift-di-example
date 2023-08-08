import Swinject

enum SwinjectContainer {
    static var shared = Container()

    static func resolve<Service>(_ serviceType: Service.Type) -> Service {
        shared.resolve(serviceType)!
    }
}
