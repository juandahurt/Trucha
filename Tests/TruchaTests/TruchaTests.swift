import XCTest
@testable import Trucha

final class TruchaTests: XCTestCase {
    let basePath = "https://foo.bar"
    
    override func setUp() {
        Trucha.sharedClient.clear()
    }
    
    func test_sharedClientBasePath_shouldBeEqualToTheOneProvided() {
        Trucha.sharedClient.setBasePath(basePath)
        XCTAssertEqual(Trucha.sharedClient.basePath, basePath)
    }
    
    func test_requestUrlshouldBeEqualToTheSumOfBasePathAndItsPath() {
        Trucha.sharedClient.setBasePath(basePath)
        let path = "/trucha"
        let request = Trucha.sharedClient.request(path)
        XCTAssertNotNil(request)
        XCTAssertEqual(request!.url.absoluteString, basePath + path)
    }
    
    func test_requestInitWithInvalidPath_shouldThrow() {
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
    
    func test_requestInitViaClientWithInvalidPathAndBasePath_shouldBeNil() {
        Trucha.sharedClient.setBasePath(basePath)
        let invalidPath = "th1s_is an_invalid_p4th"
        let request = Trucha.sharedClient.request(invalidPath)
        XCTAssertNil(request)
    }
    
    func test_requestInitViaClientWithUrlWithoutBasePath_shouldInitSuccessfuly() {
        let rawUrl = "https://bar.co"
        let request = Trucha.sharedClient.request(rawUrl)
        XCTAssertNotNil(request)
    }
    
    func testRequestStart_withValidUrl_shouldReturnResponse() async throws {
        let url = "https://api.publicapis.org/entries"
        let request = Trucha.sharedClient.request(url)
        let response = try? await request?.start()
        XCTAssertNotNil(response)
    }
}
