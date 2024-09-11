//
//  VehicleDirection.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/21.
//

import UIKit
import Foundation
import MapKit

/**
 ## VehicleDirection
 
 This class is using to fetch distance and center location.
 
 */

@objcMembers public final class VehicleDirection: NSObject {
    
    /// Request to fetch travel distance
    ///
    /// - Parameters:
    ///   - destLat: latitude
    ///   - destLong: longitude
    ///   - completion: distance or error

    public static func getTravelDistance(destLat: Double,
                                         destLong: Double,
                                         completion: @escaping (String, Error?) -> ())  {
        
        let myLocation = CLLocation(latitude: self.myLocationCoordinate().latitude, longitude: self.myLocationCoordinate().longitude)
        
        let carLocation = CLLocation(latitude: destLat, longitude: destLong)
        
        let distance = myLocation.distance(from: carLocation) / 1000
        completion("\(round(distance)) \("direction.kilometer".localized())", nil)
    }
    
    /// Request to fetch dummy center location using provided coordinators
    ///
    /// - Parameters:
    ///   - return: latitude and longitude
    
    public static func myLocationCoordinate() -> CLLocationCoordinate2D {
        
        let location1 = CLLocationCoordinate2D(latitude: Double(VehicleConstants.sourceLat) ?? 0, longitude: Double(VehicleConstants.sourceLong) ?? 0)
        let location2 = CLLocationCoordinate2D(latitude: Double(VehicleConstants.destLat) ?? 0, longitude: Double(VehicleConstants.destLong) ?? 0)
        
        
        let lon1 = location1.longitude * .pi / 180
        let lon2 = location2.longitude * .pi / 180
        let lat1 = location1.latitude * .pi / 180
        let lat2 = location2.latitude * .pi / 180
        let dLon = lon2 - lon1
        let x = cos(lat2) * cos(dLon)
        let y = cos(lat2) * sin(dLon)
        
        let lat3 = atan2( sin(lat1) + sin(lat2), sqrt((cos(lat1) + x) * (cos(lat1) + x) + y * y) )
        let lon3 = lon1 + atan2(y, cos(lat1) + x)
        
        let center: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat3 * 180 / .pi, lon3 * 180 / .pi)
        return center
    }
}
