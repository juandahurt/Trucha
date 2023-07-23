//
//  TruchaBaseRequest.swift
//  
//
//  Created by Juan Hurtado on 22/07/23.
//

import Foundation

public class TruchaBaseRequest {
    /// The HTTP method.
    var method: TruchaMethod
    
    /// The request's URL.
    var url: URL
    
    internal var urlRequest: URLRequest?
    internal var dataTask: URLSessionDataTask?
    
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
    
    init(method: TruchaMethod, url: URL) {
        self.method = method
        self.url = url
    }
    
    func setupUrlRequest() {
        urlRequest = .init(url: url)
    }
}
