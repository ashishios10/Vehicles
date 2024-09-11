//
//  NetworkManager.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/22.
//

/**
 ## NetworkManager
 
 This class is useful to communicate with backend.
 
 */

import UIKit

class NetworkManager: NSObject {
    
    /// MARK: - Properties
    private let decoder = JSONDecoder()
    
    static let errorMessage = "network.genericError".localized()
    static let noInternetConnection = "network.noInternet".localized()

    
    private let engine: NetworkEngine

    init(engine: NetworkEngine = URLSession.shared) {
        self.engine = engine
    }

    /// Request generic API Call to communicate with backend
    ///
    /// - Parameters:
    ///   - request: NSMutableURLRequest
    ///   - completion: completion handler to retrieve result

    func request<T: Decodable>(_ request: Request,
                               completion: @escaping (Result<T>) -> Void) {
        guard (Reachability.currentReachabilityStatus != .notReachable) else {
            return completion(.Failure(NetworkManager.noInternetConnection))
        }

        engine.performRequest(for: request as URLRequest) { (data, response, error) in
            guard error == nil else {
                return completion(.Failure(error!.localizedDescription))
            }
            
            guard let data = data else {
                return completion(.Failure(error?.localizedDescription ?? NetworkManager.errorMessage))
            }
            
            guard let _ = String(data: data, encoding: String.Encoding.utf8) else {
                return completion(.Failure(error?.localizedDescription ?? NetworkManager.errorMessage))
            }
            do {
                let model = try self.decoder.decode(T.self, from: data)
                return completion(.Success(model))
            } catch let error {
                completion(.Failure(error.localizedDescription))
            }
        }
    }
}
