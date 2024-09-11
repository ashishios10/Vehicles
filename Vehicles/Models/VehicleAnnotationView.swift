//
//  VehicleAnnotationView.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/21.
//

import UIKit
import MapKit

final class VehicleAnnotationView: MKAnnotationView {
    var imageView: UIImageView?
    
    init?(annotation: MKAnnotation?,
          reuseIdentifier: String?,
          image: UIImage?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.clear
        let frame = CGRect(x: 0, y: 0, width: image?.size.width ?? 0.0, height: (image?.size.height ?? 0.0))
        self.frame = frame
        centerOffset = CGPoint(x: 0, y: -frame.height / 2)
        let imageView = UIImageView(image: image)
        self.imageView = imageView
        addSubview(imageView)
        
        var imageFrame = imageView.frame
        imageFrame.origin.x = (frame.width - imageFrame.width) / 2
        imageFrame.origin.y = frame.height - imageFrame.height
        imageView.frame = imageFrame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
