import Foundation
import NeedleFoundation

protocol NeedleDependency: Dependency {
    var fooRepository: FooRepository { get }
}
