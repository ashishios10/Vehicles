//
//  VehiclesInteractor.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/20.
//

/**
 ## VehiclesInteractor
 
 This class implements VehiclesBoundary methods.
 
 */

import UIKit

@objc(VehiclesInteractor)
public class VehiclesInteractor: NSObject {
    
    private let networkManger: NetworkManager?
    
    convenience public override init() {
        self.init(networkManger:NetworkManager())
    }
    
    init(networkManger: NetworkManager?) {
        self.networkManger = networkManger
        super.init()
    }
    
    private func processVehiclesResponse(_ responseModel: VehiclesResults) -> [VehicleModelContract]? {
        if let vehicles = responseModel.poiList {
            let filterdVehicles = vehicles.filter{ $0.type?.lowercased() == Vehicletype.taxi.rawValue.lowercased() && $0.state?.lowercased() == VehicleStatus.active.rawValue }
            return VehicleReponseProcessor.processVehicleResponse(with: filterdVehicles)
        }
        return nil
    }
}

extension VehiclesInteractor: VehiclesBoundary {
    
    
    /// Vehicle API Call using the "fetchTaxies" method, to retrieve nearby taxies based on provided coordinates
    ///
    /// - Parameters:
    ///   - completion: completion handler to retrieve result or it returns the error message
    
    public func fetchTaxies(completion: @escaping (_ vehicles: [VehicleModelContract]?,
                                                   _ errorMessage: String?) -> Void) {
        
        guard let request = RequestConfig.fetchVehicle.value else {
            return
        }
        self.networkManger?.request(request) { (result: Result<VehiclesResults>) in
            switch result {
            case .Success(let responseData):
                if let vehicles = self.processVehiclesResponse(responseData) {
                    return completion(vehicles, nil)
                } else {
                    return completion(nil, NetworkManager.errorMessage)
                }
            case .Failure(let message):
                return completion(nil, message)
            case .Error(let error):
                return completion(nil, error)
            }
        }
    }
}
