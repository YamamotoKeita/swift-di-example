import Foundation

struct SimpleContainer {
    static var shared: SimpleContainer!

    var fooRepository: FooRepository
    var fooUseCase: FooUseCase
}
