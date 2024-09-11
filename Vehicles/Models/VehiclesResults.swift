//
//  VehiclesResults.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/20.
//

import UIKit

enum Vehicletype: String {
    case taxi
    case ride
    case eScooter
}

@objcMembers public final class VehiclesResults: NSObject, Codable {
    let poiList: [Vehicle]?
    
    enum CodingKeys: String, CodingKey {
        case poiList = "poiList"
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        poiList = try values.decodeIfPresent([Vehicle].self, forKey: .poiList)
    }
}
