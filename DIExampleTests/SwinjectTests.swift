import XCTest
@testable import DIExample

final class SwinjectTests: XCTestCase {
    func testUseCase() throws {
        let useCase = SwinjectUseCase(fooRepository: FooRepositoryMock())
        XCTAssertEqual(useCase.fetch(), "Mock")
    }
}
