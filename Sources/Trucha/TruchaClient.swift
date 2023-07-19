//
//  TruchaClient.swift
//  
//
//  Created by Juan Hurtado on 16/07/23.
//

import Foundation

/// The actual REST client
public struct TruchaClient {
    var basePath: String?
    
    /// Sets the base path for all the the requests that are created using the client
    /// - Parameter basePath: The base path
    public mutating func setBasePath(_ basePath: String) {
        self.basePath = basePath
    }
    
    /// It creates a new trucha request for you.
    ///
    /// If you haven't set the base path, you can pass the whole url as the `path` parameter.
    ///
    /// ```
    /// // if you haven't set the base path
    /// request("https://foo.bar/baz")
    ///
    /// // if you have set the base path
    /// request("/bar")
    /// ```
    ///
    /// - Parameter path: The request's path.
    /// - Returns: The created request. It can be nil if the provided path is invalid.
    public func request(_ path: String) -> TruchaRequest? {
        try? TruchaRequest(path: path)
    }
}
