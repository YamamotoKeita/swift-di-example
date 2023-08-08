import XCTest
@testable import DIExample

final class ExtensionTests: XCTestCase {
    override func setUpWithError() throws {
        ExtensionContainer.shared.fooRepository = FooRepositoryMock()
    }

    func testUseCase() throws {
        let useCase = ExtensionUseCase()
        XCTAssertEqual(useCase.fetch(), "Mock")
    }
}
