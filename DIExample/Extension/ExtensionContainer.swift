
import Foundation

struct ExtensionContainer {
    static var shared: ExtensionContainer!

    var fooRepository: FooRepository
    var fooUseCase: FooUseCase
}
