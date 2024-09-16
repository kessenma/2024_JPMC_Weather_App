//
//  App/View/CityView.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/16/24.
//

import SwiftUI

struct CityView: View {
    @ObservedObject var historyViewModel: HistoryViewModel
    @ObservedObject var cityViewModel: CityViewModel
    @State private var showWeatherSheet = false // Controls the sheet presentation
    
    var body: some View {
        VStack {
            TextField("Enter city name", text: $cityViewModel.cityName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Enter state code (optional)", text: $cityViewModel.stateCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Enter country code (optional)", text: $cityViewModel.countryCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                cityViewModel.searchCoordinates()
            }) {
                Text("Search")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            if !cityViewModel.cityResults.isEmpty {
                Text("Select a city:")
                    .font(.headline)
                    .padding(.top)
                
                // Display city results as a list
                List(cityViewModel.cityResults) { result in
                    Button(action: {
                        cityViewModel.selectCity(result) // Call the function correctly
                        showWeatherSheet = true // Show the sheet when a city is selected
                    }) {
                        VStack(alignment: .leading) {
                            Text("\(result.name), \(result.state ?? "N/A"), \(result.country)")
                            Text("Lat: \(result.lat), Lon: \(result.lon)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .frame(height: 300) // Adjust height of the list as needed
            }
        }
        .navigationTitle("Search by City")
        .padding()
        
        // Weather Sheet
        .sheet(isPresented: $showWeatherSheet) {
            if let weatherData = cityViewModel.weatherData {
                WeatherSheetView(weatherData: weatherData) // Pass the weather data to the sheet
            } else {
                Text("Loading weather data...") // Placeholder while data is loading
            }
        }
    }
}
