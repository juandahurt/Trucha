//
//  TruchaRequest.swift
//  
//
//  Created by Juan Hurtado on 18/07/23.
//

import Foundation

/// It represents an HTTP request.
public class TruchaRequest: TruchaBaseRequest {
    func start() async throws -> URLResponse {
        setupUrlRequest()
        guard let urlRequest else { preconditionFailure("url request must not be nil") }
        return try await withCheckedThrowingContinuation { continuation in
            dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error {
                    continuation.resume(throwing: error)
                }
                if let response {
                    continuation.resume(returning: response)
                }
            }
            dataTask?.resume()
        }
    }
    
    func decoding<T: Decodable>(to: T.Type) -> TruchaDecodableRequest<T> {
        .init(method: method, url: url)
    }
}


enum TruchaMethod: String {
    case get = "GET"
}
