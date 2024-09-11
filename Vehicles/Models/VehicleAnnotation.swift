//
//  VehicleAnnotation.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/21.
//

import MapKit
import UIKit

final class VehicleAnnotation: NSObject, MKAnnotation {
    var identifier = "Annotation"
    var title: String?
    var subtitle: String?
    var coordinate:CLLocationCoordinate2D
    var heading: Double
    var image: UIImage
    var type: Vehicletype = .taxi

    init(title:String, coordinate:CLLocationCoordinate2D, subtitle: String?, heading:Double, image: UIImage) {
        self.title = title
        self.coordinate = coordinate
        self.subtitle = subtitle
        self.heading = heading
        self.image = image
    }
}
