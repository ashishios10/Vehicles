//
//  MockVehiclesBoundary.swift
//  VehiclesTests
//
//  Created by Ashish Patel on 2021/11/25.
//

import Foundation

@testable import Vehicles

class MockVehiclesBoundary: NSObject {
    
    private var configureServiceClientCount = 0
    private var vehicles: [VehicleModelContract]?
    private var expectedError: String?
        
    func expectFetchTaxies(vehicles: [VehicleModelContract]?,
                                      errorMessage: String?) {
        self.vehicles = vehicles
        self.expectedError = errorMessage
        self.configureServiceClientCount += 1
    }
        
    func resetCounts() {
        configureServiceClientCount = 0
    }
    
    func verify() -> Bool {
        return configureServiceClientCount == 0
    }
}

extension MockVehiclesBoundary: VehiclesBoundary {
    func fetchTaxies(completion: @escaping (_ vehicles: [VehicleModelContract]?,
                                            _ errorMessage: String?) -> Void) {
        configureServiceClientCount-=1
        if let error = self.expectedError {
            completion(nil, error)
        }
        else {
            completion(self.vehicles, nil)
        }
    }
}
