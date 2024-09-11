//
//  Vehicle.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/20.
//

import Foundation
import MapKit

enum VehicleStatus: String {
    case active
    case inActive
}

@objcMembers public final class Vehicle: NSObject, Codable {
    var vehicleId: Double = 0
    let coordinate: VehicleCoordinate?
    let state: String?
    let type: String?
    var heading: Double = 0
    
    enum CodingKeys: String, CodingKey {
        case vehicleId = "id"
        case coordinate = "coordinate"
        case state = "state"
        case type = "type"
        case heading = "heading"
    }
    
    public required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        vehicleId = try values.decodeIfPresent(Double.self, forKey: .vehicleId) ?? 0
        coordinate = try values.decodeIfPresent(VehicleCoordinate.self, forKey: .coordinate)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        heading = try values.decodeIfPresent(Double.self, forKey: .heading) ?? 0
    }
}
