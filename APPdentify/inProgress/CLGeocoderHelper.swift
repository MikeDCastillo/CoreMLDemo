//
//  CLGeocoderHelper.swift
//  APPdentify
//
//  Created by Michael Castillo on 10/30/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//
//  https://stackoverflow.com/questions/27735835/convert-coordinates-to-city-name

import Foundation
import MapKit

    typealias JSONDictionary = [String:Any]
    
    class LocationServices {
        
        static let shared = LocationServices()
        
        let locManager = LocationManager.clLocationManager
        var currentLocation: CLLocation?
        let geoCoder = CLGeocoder()
        let authStatus = CLLocationManager.authorizationStatus()
        let inUse = CLAuthorizationStatus.authorizedWhenInUse
        let always = CLAuthorizationStatus.authorizedAlways
        
        func getAddress(completion: @escaping (_ address: JSONDictionary?, _ error: Error?) -> ()) {
            guard var currentLocation = currentLocation else { return }
            
                    // TODO: - I call requestWhenInUseAuthorization in LocationManager in prepareLocationManager. can i delete this???
            self.locManager.requestWhenInUseAuthorization()
            if self.authStatus == inUse || self.authStatus == always {
                        // TODO: - figure out what to do if location manager is nil
                currentLocation = locManager.location!
                self.geoCoder.reverseGeocodeLocation(currentLocation) { placemarks, error in
                    if let e = error {
                        completion(nil, e)
                    } else {
                        let placeArray = placemarks
                        var placeMark: CLPlacemark!
                        placeMark = placeArray?[0]
                        
                        guard let address = placeMark.addressDictionary as? JSONDictionary else { return }
                        
                        completion(address, nil)
                    }
                }
            }
        }
        
    }
