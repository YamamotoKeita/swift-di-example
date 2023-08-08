import Foundation

class PWUseCase: FooUseCase {
    @Inject(\.fooRepository) var fooRepository: FooRepository

    func fetch() -> String {
        fooRepository.fetchData()
    }
}
