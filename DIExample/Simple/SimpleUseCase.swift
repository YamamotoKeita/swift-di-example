import Foundation

class SimpleUseCase: FooUseCase {
    private let fooRepository: FooRepository

    init(fooRepository: FooRepository) {
        self.fooRepository = fooRepository
    }

    func fetch() -> String {
        return fooRepository.fetchData()
    }
}
