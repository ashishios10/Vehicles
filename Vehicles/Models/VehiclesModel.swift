//
//  VehicleModel.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/22.
//

import UIKit

@objcMembers public final class VehicleModel: NSObject, VehicleModelContract {
    public var vehicleId: NSNumber?
    
    public var heading: NSNumber?
    
    public var coordinate: VehicleCoordinate?
    
    public var state: String?
    
    public var type: String?
    
    public var vehicleImage: UIImage
    
    public var vehicleMapImage: UIImage
    
    required public init(vehicleId: NSNumber?,
                         coordinate: VehicleCoordinate?,
                         state: String?,
                         type: String?,
                         heading: NSNumber?,
                         vehicleImage: UIImage,
                         vehicleMapImage: UIImage) {
        self.vehicleId = vehicleId
        self.coordinate = coordinate
        self.state = state
        self.type = type
        self.heading = heading
        self.vehicleImage = vehicleImage
        self.vehicleMapImage = vehicleMapImage
        super.init()
    }
    
    public static func processVehicleRespose(model: Any) -> [VehicleModelContract]? {
        guard let vehicles = model as? [Vehicle] else { return nil }
        let vehicleModels: [VehicleModelContract] = vehicles.compactMap { vehicle in
            VehicleModel(vehicleId: vehicle.vehicleId as NSNumber, coordinate: vehicle.coordinate, state: vehicle.state, type: vehicle.type, heading: vehicle.heading as NSNumber, vehicleImage: UIImage(named: "Taxi")!, vehicleMapImage: UIImage(named: "TaxiPin")!)
        }.compactMap({ $0 })
        return vehicleModels
    }
}
