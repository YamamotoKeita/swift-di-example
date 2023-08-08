import XCTest
@testable import DIExample

final class BastardTests: XCTestCase {
    func testUseCase() throws {
        let useCase = BastardUseCase(fooRepository: FooRepositoryMock())
        XCTAssertEqual(useCase.fetch(), "Mock")
    }
}
