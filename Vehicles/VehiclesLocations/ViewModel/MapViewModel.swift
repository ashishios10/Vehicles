//
//  MapViewModel.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/21.
//

/**
 ## MapViewModel
 
 This ViewModel is helpful to communicate acorss the other components.
 
 */

import UIKit

final class MapViewModel: BaseViewModel {
    init(delegate: VehicleListDelegate, vehiclesBoundary: VehiclesBoundary) {
        super.init(delegate: delegate, vehiclesBoundary: vehiclesBoundary)
    }
}
