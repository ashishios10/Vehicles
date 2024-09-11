//
//  MapViewController.swift
//  Vehicles
//
//  Created by Ashish Patel on 2021/11/21.
//

/**
 ## MapViewController
 
 This class is useful to display map content.
 
 */

import UIKit
import MapKit

final class MapViewController: BaseViewController {
    private let rangeInMeters: Double = 15000
    private lazy var viewModel = MapViewModel(delegate: self, vehiclesBoundary: VehiclesInteractor())
    private var taxiAnnotations = [VehicleAnnotation]()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsUserLocation = false
        mapView.delegate = self
        return mapView
    }()
    
    private lazy var backButton: UIButton = {
        let backButton = UIButton(type: .custom)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(onBtnBackTapped), for: .touchUpInside)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        return backButton
    }()
    
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubViewWithConstraint(subView: self.mapView, leftPadding: 0, rightPadding: 0, topPadding: 0, bottomPadding: 0)
        self.view.addSubViewWithConstraint(subView: backButton, leftPadding: 10, topPadding: 50, width: 30, height: 30)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.centerViewOnBound()
        self.viewModel.getAllNearbyTaxies()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Custom actions
    @objc func onBtnBackTapped() {
        appCoordinator?.backViewControllerWithFlipLeft()
    }
    
    private func centerViewOnBound() {
        let coordinateRegion = MKCoordinateRegion.init(center: VehicleDirection.myLocationCoordinate(),
                                                       latitudinalMeters: rangeInMeters,
                                                       longitudinalMeters: rangeInMeters)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

// MARK: - MKMapView delegate

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view: VehicleAnnotationView
        guard let annotation = annotation as? VehicleAnnotation else {return nil}
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation.identifier) as? VehicleAnnotationView {
            view = dequeuedView
            
        } else {
            view = VehicleAnnotationView(annotation: annotation, reuseIdentifier: annotation.identifier, image: annotation.image)!
        }
        view.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat(annotation.heading / 180 * .pi))
        view.isEnabled = true
        view.canShowCallout = true
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let annotation = view.annotation as! VehicleAnnotation
        VehicleDirection.getTravelDistance(destLat: annotation.coordinate.latitude, destLong: annotation.coordinate.longitude) { (response, error) in
            if (error == nil) {
                let newAnnotation = VehicleAnnotation.init(title: annotation.title?.capitalized ?? "", coordinate: annotation.coordinate, subtitle: response, heading: annotation.heading, image: annotation.image)
                view.annotation = newAnnotation
            }
        }
    }
}

// MARK: - VehicleListDelegate methods

extension MapViewController {
    override func updateVehicleContent() {
        let currentAnnotations = self.mapView.annotations
        self.mapView.removeAnnotations(currentAnnotations)
        
        let _ = self.viewModel.vehicles.compactMap { vehicle in
            if let lat = vehicle.coordinate?.latitude, let long = vehicle.coordinate?.longitude {
                let cordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                let recycle = VehicleAnnotation.init(title: vehicle.type?.capitalized ?? "", coordinate: cordinate, subtitle: "", heading: Double(truncating: vehicle.heading ?? 0), image: vehicle.vehicleMapImage)
                self.taxiAnnotations.append(recycle)
            }
        }
        self.mapView.addAnnotations(self.taxiAnnotations)
    }
}
