import Foundation

protocol UsesFooRepository {
    var fooRepository: FooRepository { get }
}

extension UsesFooRepository {
    var fooRepository: FooRepository { CakeContainer.shared.fooRepository }
}
