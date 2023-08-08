
import Foundation

struct CakeContainer {
    static var shared = CakeContainer()

    let fooRepository: FooRepository

    init() {
        fooRepository = FooRepositoryImpl()
    }
}
