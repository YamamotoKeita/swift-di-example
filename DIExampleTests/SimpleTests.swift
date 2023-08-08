import XCTest
@testable import DIExample

final class SimpleTests: XCTestCase {
    func testUseCase() throws {
        let useCase = SimpleUseCase(fooRepository: FooRepositoryMock())
        XCTAssertEqual(useCase.fetch(), "Mock")
    }
}
