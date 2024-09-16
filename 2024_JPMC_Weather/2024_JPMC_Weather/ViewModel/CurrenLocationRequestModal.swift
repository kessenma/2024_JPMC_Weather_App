//
//  app/ViewModal/currenLocationRequestModal.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/15/24.
//

// this file is to house the component that asks the user if they are ok with the app tracking their location

import SwiftUI

struct CurrentLocationRequestModal: View {
    @ObservedObject var viewModel: MainViewModel
    @StateObject var currentLocationService = CurrentLocationService()
    
    var body: some View {
        VStack {
            Text("Allow location access?")
            Button(action: {
                viewModel.requestLocation()
                currentLocationService.getCurrentLocation { latitude, longitude in
                    // Use the obtained location to fetch weather data
                    WeatherAPI.fetchWeather(latitude: latitude, longitude: longitude)
                        .sink { completion in
                            if case .failure(let error) = completion {
                                print("Error fetching weather: \(error)")
                            }
                        } receiveValue: { weatherData in
                            print("Received weather data: \(weatherData)")
                            // Update the view model with the received weather data
                            viewModel.weatherData = weatherData
                        }
                        .store(in: &viewModel.cancellables)
                }
            }) {
                Text("Allow")
            }
        }
    }
}
