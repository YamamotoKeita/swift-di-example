import XCTest
@testable import DIExample

final class SwiftLeeTests: XCTestCase {
    override func setUpWithError() throws {
        FooRepositoryStore.currentValue = FooRepositoryMock()
    }

    func testUseCase() throws {
        let useCase = SwiftLeeUseCase()
        XCTAssertEqual(useCase.fetch(), "Mock")
    }
}
