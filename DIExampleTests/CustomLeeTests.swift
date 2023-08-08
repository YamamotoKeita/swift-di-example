import XCTest
@testable import DIExample

final class CustomLeeTests: XCTestCase {
    override func setUpWithError() throws {
        CustomLeeContainer.shared.fooRepository = FooRepositoryMock()
    }

    func testUseCase() throws {
        let useCase = CustomLeeUseCase()
        XCTAssertEqual(useCase.fetch(), "Mock")
    }
}
