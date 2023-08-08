import Foundation
import NeedleFoundation

final class NeedleUseCase: Component<NeedleDependency>, FooUseCase {

    var fooRepository: FooRepository { dependency.fooRepository }

    func fetch() -> String {
        return fooRepository.fetchData()
    }
}
