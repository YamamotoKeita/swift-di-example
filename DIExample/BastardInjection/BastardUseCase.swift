import Foundation

class BastardUseCase: FooUseCase {
    private let fooRepository: FooRepository

    init(fooRepository: FooRepository = BastardContainer.shared.fooRepository) {
        self.fooRepository = fooRepository
    }

    func fetch() -> String {
        fooRepository.fetchData()
    }
}
