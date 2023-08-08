import Foundation

class SwiftLeeUseCase: FooUseCase {
    @SwiftLeeInject(\.fooRepository) var fooRepository: FooRepository

    func fetch() -> String {
        return fooRepository.fetchData()
    }
}
