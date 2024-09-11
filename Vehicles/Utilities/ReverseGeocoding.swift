//
//  ReverseGeocoding.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/21.
//

import Foundation
import CoreLocation

/**
 ## ReverseGeocodingBoundary
 
 This protocol is using to fetch address details from coordinator.
 
 */

@objc(ReverseGeocodingBoundary)
public protocol ReverseGeocodingBoundary {
    func fetchAddress(latitude: Double,
                      longitude: Double,
                      completion: @escaping (_ address: String?, Error?) -> ())
}

public class ReverseGeocodingInteractor: NSObject {
    
    private func getCompleteAddress(_ placemark: CLPlacemark) -> String {
        var addressString = ""
        if let locality = placemark.locality {
            addressString = addressString + locality + ", "
        }
        if let country = placemark.country {
            addressString = addressString + country
        }
        return addressString
    }
}

extension ReverseGeocodingInteractor: ReverseGeocodingBoundary {
    
    /// Request fetch address from location API
    ///
    /// - Parameters:
    ///   - latitude: latitude
    ///   - longitude: longitude
    ///   - completion: return address or error
    
    public func fetchAddress(latitude: Double,
                             longitude: Double,
                             completion: @escaping (_ address: String?, Error?) -> ())  {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: latitude, longitude: longitude)) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else {
                completion(nil, error)
                return
            }
            let completeAddress = self.getCompleteAddress(placemark)
            completion(completeAddress, nil)
        }
    }
}

