import NeedleFoundation

class NeedleComponent: BootstrapComponent {
    var fooRepository: FooRepository {
        shared { FooRepositoryImpl() }
    }

    var fooUseCase: FooUseCase {
        shared { NeedleUseCase(parent: self) }
    }
}
