//
//  VehiclesBoundary.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/22.
//

import UIKit

/// VehiclesBoundary is a protocol to define set of vehicle API contract

@objc(VehiclesBoundary)
public protocol VehiclesBoundary {
    func fetchTaxies(completion: @escaping (_ vehicles: [VehicleModelContract]?,
                                            _ errorMessage: String?) -> Void)
}
