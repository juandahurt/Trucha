import XCTest
@testable import Trucha

final class TruchaTests: XCTestCase {
    let basePath = "https://foo.bar"
    

    func testSharedClientBasePath_withProvidedBasePath_shouldBeEqualToTheOneProvided() {
        Trucha.sharedClient.setBasePath(basePath)
        XCTAssertEqual(Trucha.sharedClient.basePath, basePath)
    }
}
