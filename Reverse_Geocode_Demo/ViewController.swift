//
//  ViewController.swift
//  Reverse_Geocode_Demo
//
//  Created by Galina on 21.11.2022.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    /* MARK: Project taken from: https://www.coursera.org/learn/games/lecture/CdQWd/reverse-geocode-case-study-01*/
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var geocodeLabel: UILabel!
    @IBOutlet weak var pinIcon: UIImageView!
    
    var geocoder: CLGeocoder!
    var isLookingUp = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        geocoder = CLGeocoder()
        geocodeLabel.text = ""
        geocodeLabel.alpha = 0.5
        mapView.delegate = self
    }
    
    func locationAtcenterOfMapView () -> CLLocationCoordinate2D {
        let centerOfPin = CGPoint(x: pinIcon.bounds.midX, y: pinIcon.bounds.midY)
        return mapView.convert(centerOfPin, toCoordinateFrom: pinIcon)
        
    }
    
    func startReverseGeocodeLocation(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            if error != nil {
                
                
                let alert = UIAlertController(title: "There was a problem reverse geocoding", message: error!.localizedDescription, preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
                
                
            }
            
            let mappedPlacesDescriptions = NSMutableSet()
            
            guard let placemarks = placemarks else {return}
            
            for placemark in placemarks {
                
                if placemark.name != nil {
                    mappedPlacesDescriptions.add(placemark.name!)
                }
                
                if placemark.administrativeArea != nil {
                    mappedPlacesDescriptions.add(placemark.administrativeArea!)
                }
                
                if placemark.country != nil {
                    mappedPlacesDescriptions.add(placemark.country!)
                  
                    guard let areasOfInterest = placemark.areasOfInterest else {return}
                    mappedPlacesDescriptions.addObjects(from: areasOfInterest)
                }
              
                self.geocodeLabel.text = (mappedPlacesDescriptions.allObjects as! [String]).joined(separator: "\n")
                self.geocodeLabel.alpha = 1.0
           
                self.isLookingUp = false
            }
            
        }
    }
    
    func callBackFunction() {
        
        if isLookingUp == false {
       
        isLookingUp = true
        let coordinate = locationAtcenterOfMapView()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        startReverseGeocodeLocation(location: location)
    }
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        callBackFunction()
    }
}
