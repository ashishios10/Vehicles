//
//  VehicleModelContract.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/22.
//

import UIKit

@objc(VehicleModelContract)
public protocol VehicleModelContract {
    var vehicleId: NSNumber? {get}
    var coordinate: VehicleCoordinate? {get}
    var state: String? {get}
    var type: String? {get}
    var heading: NSNumber? {get}
    var vehicleImage: UIImage {get}
    var vehicleMapImage: UIImage {get}
    
    static func processVehicleRespose(model: Any) -> [VehicleModelContract]?
}
