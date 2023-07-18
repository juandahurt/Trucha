import XCTest
@testable import Trucha

final class TruchaTests: XCTestCase {
    let basePath = "https://foo.bar"
    
    override func setUp() {
        Trucha.sharedClient.setBasePath(basePath)
    }
    
    func test_sharedClientBasePath_shouldBeEqualToTheOneProvided() throws {
        XCTAssertEqual(Trucha.sharedClient.basePath, basePath)
    }
    
    func test_requestURL_shouldBeEqualToTheSumOfBasePathAndItsPath() throws {
        let path = "/trucha"
        let request = Trucha.sharedClient.request(path)
        XCTAssertEqual(request.url.absoluteString, basePath + path)
    }
}
