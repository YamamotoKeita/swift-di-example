import Foundation

class SwinjectUseCase: FooUseCase {
    private let fooRepository: FooRepository

    init(fooRepository: FooRepository) {
        self.fooRepository = fooRepository
    }

    func fetch() -> String {
        return fooRepository.fetchData()
    }
}
