import Foundation

class ExtensionUseCase: FooUseCase, UsesFooRepository {
    func fetch() -> String {
        return fooRepository.fetchData()
    }
}
