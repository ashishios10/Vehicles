//
//  File.swift
//  VehiclesTests
//
//  Created by Ashish Patel on 2021/11/25.
//

import Foundation

@testable import Vehicles

@objcMembers public class TestDataGenerator: NSObject {
    
    @objc static func getGenerateError(messsage: String) -> NSError? {
        return NSError(domain: "com.example.error", code: 0, userInfo: [NSLocalizedDescriptionKey: messsage])
    }
    
    @objc static func getDummyVehicleModelContract() -> [VehicleModelContract]? {
        let model = VehicleModel(vehicleId: 0, coordinate: nil, state: nil, type: "", heading: 0, vehicleImage: UIImage(named: "Taxi")!, vehicleMapImage: UIImage(named: "TaxiPin")!)
        return [model]
    }
    
    @objc static func executeRunLoop() {
        RunLoop.current.run(until: Date()+1)
    }
    
    // Convert from JSON to nsdata
    @objc static func getMockData() -> Data? {
       let json = "{\n\t\"poiList\": [{\n\t\t\t\"id\": 2056168816,\n\t\t\t\"coordinate\": {\n\t\t\t\t\"latitude\": 53.57454353146161,\n\t\t\t\t\"longitude\": 9.993014261126518\n\t\t\t},\n\t\t\t\"state\": \"ACTIVE\",\n\t\t\t\"type\": \"TAXI\",\n\t\t\t\"heading\": 171.7456512451172\n\t\t},\n\t\t{\n\t\t\t\"id\": 1650301919,\n\t\t\t\"coordinate\": {\n\t\t\t\t\"latitude\": 53.57346550457878,\n\t\t\t\t\"longitude\": 9.980390779674053\n\t\t\t},\n\t\t\t\"state\": \"ACTIVE\",\n\t\t\t\"type\": \"TAXI\",\n\t\t\t\"heading\": 359.74139404296875\n\t\t}\n\t]\n}"
        return Data(json.utf8)
    }
}
