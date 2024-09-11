//
//  NetworkEngine.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/25.
//

/**
 ## NetworkEngine
 
 This protocol is using to communicate with URLSession.
 
 */

import UIKit

protocol NetworkEngine {
    typealias Handler = (Data?, URLResponse?, Error?) -> Void

    func performRequest(for request: URLRequest, completionHandler: @escaping Handler)
}

extension URLSession: NetworkEngine {
    typealias Handler = NetworkEngine.Handler

    /// Request to perform opetion with bakend
    ///
    /// - Parameters:
    ///   - request: URLRequest
    ///   - completion: returns data, URLResponse or error

    func performRequest(for request: URLRequest, completionHandler: @escaping Handler) {
        let task = dataTask(with: request, completionHandler: completionHandler)
        task.resume()
    }
}
