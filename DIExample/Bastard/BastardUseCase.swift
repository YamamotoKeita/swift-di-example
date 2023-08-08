import Foundation

class BastardUseCase: FooUseCase {
    private let fooRepository: FooRepository

    init(fooRepository: FooRepository = FooRepositoryImpl()) {
        self.fooRepository = fooRepository
    }

    func fetch() -> String {
        return fooRepository.fetchData()
    }
}
