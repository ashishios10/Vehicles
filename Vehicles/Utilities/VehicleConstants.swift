//
//  VehicleConstants.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/22.
//

/**
 ## VehicleConstants
 
 This class is using to provide constant values .
 
 */

final class VehicleConstants: NSObject {
    static let baseUrl = "Your API"
    static let vehicleSuffixURL = "/poi/v1"
    static let sourceLat = "53.694865"
    static let sourceLong = "9.757589"
    static let destLat = "53.394655"
    static let destLong = "10.099891"
    
    static let fetchVehicleUrl = "\(baseUrl)\(vehicleSuffixURL)?p2Lat=\(destLat)&p1Lon=\(sourceLong)&p1Lat=\(sourceLat)&p2Lon=\(destLong)"
}
