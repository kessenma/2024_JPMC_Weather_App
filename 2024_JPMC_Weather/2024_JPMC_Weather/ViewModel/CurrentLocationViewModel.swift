//
//  app/ViewModal/CurrentLocationViewModel.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/14/24.

// used this guide to gain access to CoreLocation and CLocation: https://coledennis.medium.com/tutorial-connecting-core-location-to-a-swiftui-app-dc62563bd1de


import SwiftUI
import Combine
import CoreLocation

class CurrentLocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var isLocationPermissionGranted = false
    @Published var errorMessage: String?
    @Published var currentLocation: CLLocation?
    @Published var weatherData: WeatherModel?
    
    private let locationManager = CLLocationManager()
    private var cancellables = Set<AnyCancellable>()
    
    override init() {
        super.init()
        locationManager.delegate = self
        checkLocationAuthorization()
    }
    
    func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            isLocationPermissionGranted = true
        case .denied, .restricted:
            errorMessage = "Location access denied. Please enable it in settings."
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }
    
    func requestLocation() {
        if isLocationPermissionGranted {
            locationManager.requestLocation()
        } else {
            checkLocationAuthorization()
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        
        // Fetch the weather based on the current location
        fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = "Failed to get location: \(error.localizedDescription)"
    }
    
    private func fetchWeather(latitude: Double, longitude: Double) {
        WeatherAPI.fetchWeather(latitude: latitude, longitude: longitude)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = "Failed to fetch weather: \(error.localizedDescription)"
                }
            } receiveValue: { weatherData in
                self.weatherData = weatherData
            }
            .store(in: &cancellables)
    }
}
