//
//  MapsViewController.swift
//  NearMe
//
//  Created by Mohammad Azam on 1/24/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit
import MapKit

protocol MapsViewControllerDelegate : class {
    
    func mapsViewControllerDidSelectAnnotation(mapItem :MKMapItem)
}

class MapsViewController : UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView :MKMapView!
    
    weak var delegate :MapsViewControllerDelegate!
    var locationManager :CLLocationManager!
    var place :Place! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager = CLLocationManager()
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
        
        self.locationManager.requestAlwaysAuthorization()
        self.mapView.showsUserLocation = true
    }
    
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) {
        
        let annotationView = views.first!
        
        if let annotation = annotationView.annotation {
            if annotation is MKUserLocation {

                var region = MKCoordinateRegion()
                region.center = self.mapView.userLocation.coordinate
                region.span.latitudeDelta = 0.025
                region.span.longitudeDelta = 0.025
                
                self.mapView.setRegion(region, animated: true)
                
                populateNearByPlaces()

            }
        }
        
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let annotation = view.annotation as! PlaceAnnotation
        self.delegate.mapsViewControllerDidSelectAnnotation(mapItem: annotation.mapItem)
    }
    
    func populateNearByPlaces() {
        
        var region = MKCoordinateRegion()
        region.center = CLLocationCoordinate2D(latitude: self.mapView.userLocation.coordinate.latitude, longitude: self.mapView.userLocation.coordinate.longitude)
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = self.place.title
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            
            guard let response = response else {
                return
            }
            
            for item in response.mapItems {
                
                let annotation = PlaceAnnotation()
                annotation.coordinate = item.placemark.coordinate
                annotation.title = item.name
                annotation.mapItem = item
                
                DispatchQueue.main.async {
                    self.mapView.addAnnotation(annotation)
                }
                
                
            }
            
        }
        
    }
    
}
