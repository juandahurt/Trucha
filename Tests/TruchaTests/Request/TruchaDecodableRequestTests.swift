//
//  TruchaDecodableRequestTests.swift
//  
//
//  Created by Juan Hurtado on 22/07/23.
//

import XCTest
@testable import Trucha

final class TruchaDecodableRequestTests: XCTestCase {
    let url = "https://api.publicapis.org/entries"
    
    func testDecodableRequest_withValidUrl_shouldDecodeCorrectly() async {
        let res = try? await TruchaRequest(path: url)
            .decoding(to: Response.self)
            .start()
        XCTAssertNotNil(res)
    }
    
    func testDecodableRequest_withInvalidDecodable_shouldThrow() async {
        do {
            let _ = try await TruchaRequest(path: url)
                .decoding(to: WrongResponse.self)
                .start()
        } catch {
            guard let truchaError = error as? TruchaError else {
                XCTFail("wrong error thrown!!")
                return
            }
            XCTAssertEqual(truchaError, .unableToDecode)
        }
    }
}

// MARK: - Helpers
struct Response: Decodable {
    var count: Int
}

struct WrongResponse: Decodable {
    var name: String
}
