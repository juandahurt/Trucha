//
//  TruchaDecodableRequest.swift
//  
//
//  Created by Juan Hurtado on 22/07/23.
//

import Foundation

///
public class TruchaDecodableRequest<T>: TruchaBaseRequest where T: Decodable {
    /// Starts a decodable request.
    /// - Returns: The decoded response.
    func start() async throws -> T {
        setupUrlRequest()
        return try await withCheckedThrowingContinuation { continuation in
            dataTask = URLSession.shared.dataTask(with: urlRequest!) { data, _, error in
                if let error {
                    continuation.resume(throwing: error)
                }
                if let data {
                    guard let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                        continuation.resume(throwing: TruchaError.unableToDecode)
                        return
                    }
                    continuation.resume(returning: decoded)
                }
            }
            dataTask?.resume()
        }
    }
}
