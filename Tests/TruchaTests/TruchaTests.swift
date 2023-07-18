import XCTest
@testable import Trucha

final class TruchaTests: XCTestCase {
    func test_sharedClientBasePath_shouldBeEqualToTheOneProvided() throws {
        let basePath = "https://foo.bar"
        Trucha.sharedClient.setBasePath(basePath)
        XCTAssertEqual(Trucha.sharedClient.basePath, basePath)
    }
}
