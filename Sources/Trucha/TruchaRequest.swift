//
//  TruchaRequest.swift
//  
//
//  Created by Juan Hurtado on 18/07/23.
//

import Foundation

/// It represents an HTTP request.
public struct TruchaRequest {
    /// The HTTP method.
    var method: TruchaMethod
    
    /// The request's URL.
    var url: URL
    
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
}


enum TruchaMethod: String {
    case get = "GET"
}
