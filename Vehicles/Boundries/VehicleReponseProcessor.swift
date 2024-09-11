//
//  VehicleReponseProcessor.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/22.
//


/**
 ## VehicleReponseProcessor
 
 This class uses to process reponse based on request types.
 Implemented chain of responsibility desing pattern
 
 */

import UIKit

final class VehicleReponseProcessor {
    
    /// This api is useful to process response of releant API and it checks with the relevant model which confirms the VehicleModelContract abstraction
    ///
    /// - Parameters: model
    /// - returns: array of VehicleModelContract

    static func processVehicleResponse(with model: Any) -> [VehicleModelContract] {
        let vhicleTypes = [VehicleModel.self]
        let exploreOffers: [VehicleModelContract] = vhicleTypes.compactMap { type in
            VehicleReponseProcessor.processResponse(with: type as VehicleModelContract.Type, model: model)
        }.flatMap({$0})
        return exploreOffers
    }
    
    static func processResponse(with type: VehicleModelContract.Type,
                                model: Any) -> [VehicleModelContract]? {
        if let vehicles = type.processVehicleRespose(model: model) {
            return vehicles
        }
        return nil
    }
}
