//
//  BaseViewModel.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/21.
//

/**
 ## BaseViewModel
 
 This class is base view mode which provided common implementations.
 
 */

import UIKit

/// Base view model is providing resuable api call.
@objcMembers public class BaseViewModel: NSObject {
    public weak var delegate: VehicleListDelegate?
    public var vehiclesBoundary: VehiclesBoundary?
    public var asynRunner: AsynchronousRunner
    public var vehicles = [VehicleModelContract]()
    
    init(delegate: VehicleListDelegate,
         vehiclesBoundary: VehiclesBoundary,
         asynRunner: AsynchronousRunner = AsynchronousRunnerImplementation()) {
        self.delegate = delegate
        self.vehiclesBoundary = vehiclesBoundary
        self.asynRunner = asynRunner
        super.init()
    }
    
    public func getAllNearbyTaxies() {
        self.delegate?.showLoader()
        self.asynRunner.runOnConcurrent {
            self.vehiclesBoundary?.fetchTaxies{ (vehicles, error) in
                self.asynRunner.runOnMain { [weak self] in
                    self?.delegate?.dismissLoader()
                    if error != nil {
                        self?.delegate?.showToast(error ?? "")
                    }
                    else {
                        if let vehicles = vehicles, !vehicles.isEmpty {
                            self?.handleSuccessResponse(vehicles)
                        }
                    }
                }
            }
        }
    }
    
    private func handleSuccessResponse(_ vehicles: [VehicleModelContract]) {
        if !self.vehicles.isEmpty {
            self.vehicles.removeAll()
        }
        self.vehicles.append(contentsOf: vehicles)
        self.delegate?.updateVehicleContent()
    }
}
