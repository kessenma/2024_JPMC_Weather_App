//
//  CurrentLocationView.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/16/24.
//

import SwiftUI

struct CurrentLocationView: View {
    @ObservedObject var viewModel: CurrentLocationViewModel
    @State private var showWeatherSheet = false
    
    var body: some View {
        VStack {
            Button(action: {
                viewModel.requestLocation()
            }) {
                Text("Get Current Location")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            if let location = viewModel.currentLocation {
                Text("Latitude: \(location.coordinate.latitude)")
                Text("Longitude: \(location.coordinate.longitude)")
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .onAppear {
            viewModel.checkLocationAuthorization()
        }
        // Use the single-parameter closure for iOS 17+
        .onChange(of: viewModel.weatherData) { newWeatherData in
            if newWeatherData != nil {
                showWeatherSheet = true
            }
        }
        // Display the WeatherSheetView when weather data is available
        .sheet(isPresented: $showWeatherSheet) {
            if let weatherData = viewModel.weatherData {
                WeatherSheetView(weatherData: weatherData)
            } else {
                Text("Loading weather data...")
            }
        }
    }
}
