//
//  ViewController.swift
//  The Pixel City
//
//  Created by Madian on 4/21/19.
//  Copyright © 2019 Madian. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapVc: UIViewController {

    //MARK: Properties
    
    //get location manager object
    var locationManager = CLLocationManager()
    //get Auth status for our device
    var authorizationStatus = CLLocationManager.authorizationStatus()
    // region raduis
    let regionRaduis: Double = 1000.0
    
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set MapVC to be a delegate for mapView
        mapView.delegate = self
        
        //set MapVC to be a delegate for locationManager
        locationManager.delegate = self
        
        //Config location services
        configLocationServices()
    }
    
    //MARK: - Actions
    @IBAction func centermapPressed(_ sender: Any) {
        if authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocaion()
        }
    }
}

extension MapVc: MKMapViewDelegate {
    
    func centerMapOnUserLocaion(){
        // get coordinates of our location
        guard let coordinates = locationManager.location?.coordinate else {return}
        // setup coordinates region
        let coordinateRegion = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionRaduis, longitudinalMeters: regionRaduis)
        mapView.setRegion(coordinateRegion, animated: true)
        
      //  print("\(coordinates.latitude) and \(coordinates.longitude)")
    }
    
}


extension MapVc: CLLocationManagerDelegate {
    func configLocationServices(){
        ///check if we have authorized to get device location
        
        if authorizationStatus == .notDetermined {
            // if we not authorized to get location status, ask for it.
            // if we already have it , do nothing.
            locationManager.requestAlwaysAuthorization()
            authorizationStatus = CLLocationManager.authorizationStatus()
        } else {
             authorizationStatus = CLLocationManager.authorizationStatus()
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocaion()
    }
}
