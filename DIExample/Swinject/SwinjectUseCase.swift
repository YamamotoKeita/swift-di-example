import Foundation

class SwinjectUseCase: FooUseCase {
    private let fooRepository: FooRepository

    init(fooRepository: FooRepository) {
        self.fooRepository = fooRepository
    }

    func fetch() -> String {
        fooRepository.fetchData()
    }
}
