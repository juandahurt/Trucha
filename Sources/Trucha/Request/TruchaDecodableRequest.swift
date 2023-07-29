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
        try setupUrlRequest()
        return try await withCheckedThrowingContinuation { continuation in
            dataTask = URLSession.shared.dataTask(with: urlRequest!) { [weak self] data, _, error in
                guard let self else { return }
                if let error {
                    continuation.resume(throwing: error)
                }
                if let data {
                    let decoder = self.config.decoder
                    guard let decoded: T = try? decoder.decode(data) else {
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


protocol TruchaDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

extension JSONDecoder: TruchaDecoder {
    func decode<T>(_ data: Data) throws -> T where T : Decodable {
        try self.decode(T.self, from: data)
    }
}
