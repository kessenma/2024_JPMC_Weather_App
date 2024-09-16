//
//  MainView.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/15/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @ObservedObject var historyViewModel: HistoryViewModel
    @ObservedObject var cityViewModel: CityViewModel
    @StateObject private var currentLocationViewModel = CurrentLocationViewModel()

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: CurrentLocationView(viewModel: currentLocationViewModel)) {
                    Text("Current Location Weather")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                NavigationLink(destination: CityView(historyViewModel: historyViewModel, cityViewModel: cityViewModel)) {
                    Text("Search Weather by City")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                NavigationLink(destination: HistoryView(historyViewModel: historyViewModel, cityViewModel: cityViewModel)) {
                    Text("History")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                if viewModel.isLocationPermissionGranted {
                    if let weatherData = viewModel.weatherData {
                        WeatherView(weatherData: weatherData)
                    } else {
                        ProgressView("Loading weather data...")
                    }
                }

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct WeatherView: View {
    let weatherData: WeatherModel
    
    var body: some View {
        VStack {
            Text(weatherData.name)
                .font(.title)
            
            if let weather = weatherData.weather.first {
                Text(weather.description)
                    .font(.subheadline)
            }
            
            Text("\(Int(weatherData.main.temp))°C")
                .font(.largeTitle)
        }
    }
}
