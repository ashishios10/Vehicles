//
//  Request.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/22.
//

/**
 ## NetworkManager
 
 This enum is useful to confirgure backend communication.
 
 */

import UIKit

enum RequestConfig {
    
    case fetchVehicle
    
    var value: Request? {
        
        switch self {
        
        case .fetchVehicle:
            let reqConfig = Request.init(requestMethod: .get, urlString: VehicleConstants.fetchVehicleUrl)
            return reqConfig
        }
    }
}

enum RequestMethod: String {
    case get  = "GET"
    case post = "POST"
    case put  = "PUT"
    
    var value: String {
        return self.rawValue
    }
}

/**
 ## Request
 
 This class provides URLRequest.
 
 */

final class Request: NSMutableURLRequest {
    
    convenience init?(requestMethod: RequestMethod,
                      urlString: String,
                      bodyParams: [String: Any]? = nil) {
        guard let url =  URL.init(string: urlString) else {
            return nil
        }
        self.init(url: url)
        do {
            if let bodyParams = bodyParams {
                let data = try JSONSerialization.data(withJSONObject: bodyParams, options: .prettyPrinted)
                self.httpBody = data
            }
        } catch {}
        self.httpMethod = requestMethod.value
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
