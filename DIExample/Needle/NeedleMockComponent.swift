import NeedleFoundation

class NeedleMockComponent: BootstrapComponent {
    var fooRepository: FooRepository {
        shared { FooRepositoryMock() }
    }

    var fooUseCase: FooUseCase {
        shared { NeedleUseCase(parent: self) }
    }
}
