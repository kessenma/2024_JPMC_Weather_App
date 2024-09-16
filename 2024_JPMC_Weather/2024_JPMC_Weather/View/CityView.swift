//
//  App/View/CityView.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/16/24.
//

import SwiftUI

struct CityView: View {
    @ObservedObject var cityViewModel = CityViewModel() // Use ObservedObject here
    
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

            if let coordinates = cityViewModel.cityCoordinates {
                if !coordinates.lat.isNaN && !coordinates.lon.isNaN {
                    Text("Coordinates: \(coordinates.lat), \(coordinates.lon)")
                } else {
                    Text("Invalid coordinates received.")
                        .foregroundColor(.red)
                }
            }

            if let errorMessage = cityViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("Search by City")
        .padding()
    }
}
