import Foundation

class CakeUseCase: FooUseCase, UsesFooRepository {
    func fetch() -> String {
        fooRepository.fetchData()
    }
}
