//
//  NetworkManager.swift
//  VehiclesTests
//
//  Created by Ashish Patel on 2021/11/25.
//

import Foundation
@testable import Vehicles

class MockNetworkEngine: NSObject {
    
    private var configureServiceClientCount = 0
    private var expectedData: Data?
    private var expectedError: NSError?
    
    func expectPerformRequest(data: Data?,
                              error: NSError?) {
        self.expectedData = data
        self.expectedError = error
        self.configureServiceClientCount += 1
    }
    
    func resetCounts() {
        configureServiceClientCount = 0
    }
    
    func verify() -> Bool {
        return configureServiceClientCount == 0
    }
}

extension MockNetworkEngine: NetworkEngine {
    func performRequest(for request: URLRequest, completionHandler: @escaping Handler) {
        configureServiceClientCount-=1
        if let error = self.expectedError {
            completionHandler(nil, nil, error)
        }
        else {
            completionHandler(self.expectedData, nil, nil)
        }
    }
}
