import Foundation

protocol UsesFooRepository {
    var fooRepository: FooRepository { get }
}
extension UsesFooRepository {
    var fooRepository: FooRepository { ExtensionContainer.shared.fooRepository }
}


protocol UsesFooUseCase {
    var fooUseCase: FooUseCase { get }
}
extension UsesFooUseCase {
    var fooUseCase: FooUseCase { ExtensionContainer.shared.fooUseCase }
}
