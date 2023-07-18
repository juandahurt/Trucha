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
}
