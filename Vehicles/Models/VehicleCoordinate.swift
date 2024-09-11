//
//  VehicleCoordinate.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/21.
//

import Foundation

@objcMembers public final class VehicleCoordinate: NSObject, Codable {
    var latitude: Double = 0
    var longitude: Double = 0
    
    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latitude = try (values.decodeIfPresent(Double.self, forKey: .latitude) ?? 0)
        longitude = try (values.decodeIfPresent(Double.self, forKey: .longitude) ?? 0)
    }
}
