

import Foundation
import NeedleFoundation

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class NeedleDependency74c66fcd26c1af76c373Provider: NeedleDependency {
    var fooRepository: FooRepository {
        return needleComponent.fooRepository
    }
    private let needleComponent: NeedleComponent
    init(needleComponent: NeedleComponent) {
        self.needleComponent = needleComponent
    }
}
/// ^->NeedleComponent->NeedleUseCase
private func factory425d00bca5ea9bc52fd0a2925bf8090e1a2f8c18(_ component: NeedleFoundation.Scope) -> AnyObject {
    return NeedleDependency74c66fcd26c1af76c373Provider(needleComponent: parent1(component) as! NeedleComponent)
}
private class NeedleDependency1dde335932eb841c365eProvider: NeedleDependency {
    var fooRepository: FooRepository {
        return needleMockComponent.fooRepository
    }
    private let needleMockComponent: NeedleMockComponent
    init(needleMockComponent: NeedleMockComponent) {
        self.needleMockComponent = needleMockComponent
    }
}
/// ^->NeedleMockComponent->NeedleUseCase
private func factoryf33c8c51fba6e5b0a473f1b99c4da6b4588ce0ee(_ component: NeedleFoundation.Scope) -> AnyObject {
    return NeedleDependency1dde335932eb841c365eProvider(needleMockComponent: parent1(component) as! NeedleMockComponent)
}

#else
extension NeedleComponent: Registration {
    public func registerItems() {


    }
}
extension NeedleUseCase: Registration {
    public func registerItems() {
        keyPathToName[\NeedleDependency.fooRepository] = "fooRepository-FooRepository"
    }
}
extension NeedleMockComponent: Registration {
    public func registerItems() {


    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->NeedleComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->NeedleComponent->NeedleUseCase", factory425d00bca5ea9bc52fd0a2925bf8090e1a2f8c18)
    registerProviderFactory("^->NeedleMockComponent->NeedleUseCase", factoryf33c8c51fba6e5b0a473f1b99c4da6b4588ce0ee)
    registerProviderFactory("^->NeedleMockComponent", factoryEmptyDependencyProvider)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
