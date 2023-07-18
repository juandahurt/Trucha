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
    
    init(method: TruchaMethod = .get, path: String) {
        self.method = method
        if let basePath = Trucha.sharedClient.basePath, let url = URL(string: basePath + path) {
            self.url = url
        } else {
            // TODO: throw error
            self.url = .init(string: "")!
        }
    }
}


enum TruchaMethod: String {
    case get = "GET"
}
