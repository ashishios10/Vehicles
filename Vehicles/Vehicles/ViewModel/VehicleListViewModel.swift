//
//  VehicleListViewModel.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/21.
//

/**
 ## VehicleListViewModel
 
 This ViewModel is helpful to communicate acorss the other components.

 */

import UIKit

@objcMembers public final class VehicleListViewModel: BaseViewModel {
    
    private var reverseGeoBoundary: ReverseGeocodingBoundary?
    
    init(delegate: VehicleListDelegate, vehiclesBoundary: VehiclesBoundary) {
        super.init(delegate: delegate, vehiclesBoundary: vehiclesBoundary)
    }
    
    convenience init(delegate: VehicleListDelegate, vehiclesBoundary: VehiclesBoundary, reverseGeoBoundary: ReverseGeocodingBoundary) {
        self.init(delegate: delegate, vehiclesBoundary: vehiclesBoundary)
        self.reverseGeoBoundary = reverseGeoBoundary
    }
    
    public func getUserAddress() {
        let location = VehicleDirection.myLocationCoordinate()
        self.reverseGeoBoundary?.fetchAddress(latitude: location.latitude, longitude: location.longitude) { [weak self] (address, error) in
            if error == nil {
                self?.delegate?.updateViewTitle?(address)
            }
        }
    }
}
