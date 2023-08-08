import Foundation

protocol FooRepository {
    func fetchData() -> String
}

class FooRepositoryImpl: FooRepository {
    private var count = 0

    func fetchData() -> String {
        count += 1
        return "Production \(count)"
    }
}

class FooRepositoryMock: FooRepository {
    func fetchData() -> String {
        return "This is Mock"
    }
}
