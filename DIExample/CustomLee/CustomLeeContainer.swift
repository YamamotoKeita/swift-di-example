import Foundation

class CustomLeeContainer {
    static var shared = CustomLeeContainer()

    var fooRepository: FooRepository?
    var fooUseCase: FooUseCase?
}
