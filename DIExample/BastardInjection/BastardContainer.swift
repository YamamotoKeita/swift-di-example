import Foundation

struct BastardContainer {
    static var shared = BastardContainer()

    let fooRepository: FooRepository

    init() {
        fooRepository = FooRepositoryImpl()
    }
}
