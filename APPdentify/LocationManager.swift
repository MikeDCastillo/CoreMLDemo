//
//  LocationManager.swift
//  APPdentify
//
//  Created by Michael Castillo on 10/25/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//
//

import UIKit
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let clLocationManager = CLLocationManager()
    
    func detectCurrentLocation() {}
    func locationAsString() {}
    
    /// Prepares the locationManager for use. Use this function in View Controller after setting the current View Controller as the delegate. Also change the NSLocationAlwaysUsageDescription in the info.plist.
    func prepareLocationManager(view: UIViewController) {
        //  asks authorization from user
        LocationManager.clLocationManager.requestAlwaysAuthorization()
        //  for use in foreground
        LocationManager.clLocationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            //  set current view as delegate
            LocationManager.clLocationManager.delegate = view as? CLLocationManagerDelegate
            LocationManager.clLocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            LocationManager.clLocationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else { return }
        var locValue: CLLocationCoordinate2D = location.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
    }
    
}

