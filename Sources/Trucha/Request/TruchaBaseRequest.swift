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
    
    var path: String
    
    internal var urlRequest: URLRequest?
    internal var dataTask: URLSessionDataTask?
    
    init(method: TruchaMethod = .get, path: String) {
        self.method = method
        self.path = path
    }
    
    func setupUrlRequest() throws {
        guard let url = URL(string: path) else {
            throw TruchaError.invalidURL
        }
        urlRequest = .init(url: url)
    }
}
