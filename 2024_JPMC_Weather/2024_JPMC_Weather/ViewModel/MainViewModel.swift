//
//  MainViewModel.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/15/24.
//

import SwiftUI
import Combine
import CoreLocation

class MainViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var isLocationPermissionGranted = false
    @Published var weatherData: WeatherModel?
    @Published var errorMessage: String?
    
    var cancellables = Set<AnyCancellable>()
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            isLocationPermissionGranted = true
            manager.startUpdatingLocation()
        case .denied, .restricted:
            errorMessage = "Location access denied. Please enable it in settings."
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        fetchWeather(for: location)
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = "Failed to get location: \(error.localizedDescription)"
    }
    
    private func fetchWeather(for location: CLLocation) {
        WeatherAPI.fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
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
