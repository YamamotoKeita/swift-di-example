import Foundation

class CustomLeeUseCase: FooUseCase {
    @CustomLeeInject(\.fooRepository) var fooRepository: FooRepository

    func fetch() -> String {
        return fooRepository.fetchData()
    }
}
