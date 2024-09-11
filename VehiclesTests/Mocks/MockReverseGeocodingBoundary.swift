//
//  MockReverseGeocodingBoundary.swift
//  VehiclesTests
//
//  Created by Ashish Patel on 2021/11/25.
//

import Foundation

@testable import Vehicles

class MockReverseGeocodingBoundary: NSObject {
    
    private var configureServiceClientCount = 0
    private var address: String?
    private var expectedError: NSError?
    
    func expectfetchAddress(address: String?,
                            error: NSError?) {
        self.address = address
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

extension MockReverseGeocodingBoundary: ReverseGeocodingBoundary {
    func fetchAddress(latitude: Double, longitude: Double, completion: @escaping (String?, Error?) -> ()) {
        configureServiceClientCount-=1
        if let error = self.expectedError {
            completion(nil, error)
        }
        else {
            completion(self.address, nil)
        }
    }
}
