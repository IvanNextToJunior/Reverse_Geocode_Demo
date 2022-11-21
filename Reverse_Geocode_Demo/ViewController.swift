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

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var geocodeLabel: UILabel!
    @IBOutlet weak var pinIcon: UIImageView!
    
    @IBAction func reverseGeocodeButtonTouchUpInside(_ sender: UIButton) {
    }
    
    var geocoder: CLGeocoder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        geocoder = CLGeocoder()
        geocodeLabel.text = ""
        geocodeLabel.alpha = 0.5
        
    }
    
    
}

