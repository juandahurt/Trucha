//
//  TruchaRequestTests.swift
//  
//
//  Created by Juan Hurtado on 22/07/23.
//

import XCTest
@testable import Trucha

final class TruchaRequestTests: XCTestCase {
    let basePath = "https://foo.bar"
    
    override func setUp() {
        Trucha.sharedClient.clear()
    }
    
    func testRequestViaClient_withInvalidPath_shouldThrow() async {
        Trucha.sharedClient.setBasePath(basePath)
        let invalidPath = "th1s_is an_invalid_p4th"
        let request = Trucha.sharedClient.request(invalidPath)
        do {
            let _ = try await request.start()
        } catch {
            guard let truchaError = error as? TruchaError else {
                XCTFail("wrong error thrown!!")
                return
            }
            XCTAssertEqual(truchaError, .invalidURL)
        }
    }
    
    func testRequestStart_withValidUrl_shouldReturnResponse() async throws {
        let url = "https://api.publicapis.org/entries"
        let request = Trucha.sharedClient.request(url)
        let response = try? await request.start()
        XCTAssertNotNil(response)
    }
}
