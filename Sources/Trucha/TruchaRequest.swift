//
//  TruchaRequest.swift
//  
//
//  Created by Juan Hurtado on 18/07/23.
//

import Foundation

/// It represents an HTTP request.
public class TruchaRequest {
    /// The HTTP method.
    var method: TruchaMethod
    
    /// The request's URL.
    var url: URL
    
    private var urlRequest: URLRequest?
    private var dataTask: URLSessionDataTask?
    
    init(method: TruchaMethod = .get, path: String) throws {
        self.method = method
        if let basePath = Trucha.sharedClient.basePath {
            guard let url = URL(string: basePath + path) else {
                throw TruchaError.invalidURL
            }
            self.url = url
        } else if let url = URL(string: path) {
            self.url = url
        } else {
            throw TruchaError.invalidURL
        }
    }
    
    func setupUrlRequest() {
        urlRequest = .init(url: url)
    }
    
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
}


enum TruchaMethod: String {
    case get = "GET"
}
