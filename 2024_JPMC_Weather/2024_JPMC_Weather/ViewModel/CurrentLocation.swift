//
//  app/ViewModal/CurrentLocation.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/14/24.

// I want this page to be interactable after the user has said yes in the CurrenLocationRequestModal
// convert the location to lattitude and longitude via making a call to this file app/api/convert/CurrentLocation.swift
// take that lat long output and make a call to this file: app/api/latLongWeatherAPI.swift
// display the weather information in the UI

import Foundation
import CoreLocation


class CurrentLocationService: NSObject, CLLocationManagerDelegate, ObservableObject {
    static let sharedInstance = CurrentLocationService()
    let locationManager = CLLocationManager()
    var completion: ((Double, Double) -> Void)?

    func getCurrentLocation(completion: @escaping (Double, Double) -> Void) {
        self.completion = completion
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationManager.stopUpdatingLocation()
        // Call the completion handler with the obtained location
        completion?(location.coordinate.latitude, location.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error.localizedDescription)")
    }
}
