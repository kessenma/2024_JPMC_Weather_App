//
//  History.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/16/24.
//

import SwiftUI


struct HistoryView: View {
    @ObservedObject var historyViewModel: HistoryViewModel
    @ObservedObject var cityViewModel: CityViewModel
    @State private var showWeatherSheet = false

    var body: some View {
        VStack {
            if historyViewModel.searchHistory.isEmpty {
                Text("Search for weather in cities to have it appear here.")
                    .padding()
                    .foregroundColor(.gray)
            } else {
                List(historyViewModel.searchHistory, id: \.self) { city in
                    Button(action: {
                        selectCityFromHistory(city: city)
                    }) {
                        Text(city)
                    }
                }
            }
            
            Button(action: {
                historyViewModel.clearHistory()
            }) {
                Text("Clear History")
                    .foregroundColor(.red)
            }
            .padding()
        }
        .navigationTitle("Search History")
        .sheet(isPresented: $showWeatherSheet) {
            if let weatherData = cityViewModel.weatherData {
                WeatherSheetView(weatherData: weatherData)
            } else {
                ProgressView("Loading weather data...")
            }
        }
    }
    
    func selectCityFromHistory(city: String) {
        cityViewModel.cityName = city
        cityViewModel.searchCoordinates()
        showWeatherSheet = true
    }
}
