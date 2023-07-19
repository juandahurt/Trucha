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
        XCTAssertNotNil(request)
        XCTAssertEqual(request!.url.absoluteString, basePath + path)
    }
    
    func test_request_shouldThrowIfPathIsInvalid() throws {
        let invalidPath = "this_is_an_invalid_path"
        do {
            let _ = try TruchaRequest(path: invalidPath)
        } catch {
            guard let truchaError = error as? TruchaError else {
                XCTFail("wrong error thrown!!")
                return
            }
            XCTAssertEqual(truchaError, .invalidURL)
        }
    }
}
