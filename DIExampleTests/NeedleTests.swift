import XCTest
@testable import DIExample


final class NeedleTests: XCTestCase {
    func testUseCase() throws {
        let useCase = NeedleMockComponent().fooUseCase
        XCTAssertEqual(useCase.fetch(), "Mock")
    }
}
