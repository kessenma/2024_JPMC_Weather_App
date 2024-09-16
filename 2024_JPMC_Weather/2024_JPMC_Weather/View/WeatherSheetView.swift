//
//  WeatherSheetView.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/16/24.
//

import SwiftUI

struct WeatherSheetView: View {
    let weatherData: WeatherModel

    var body: some View {
        VStack {
            Text("Weather in \(weatherData.name):")
                .font(.largeTitle)
                .padding()

            Text("Temperature: \(weatherData.main.temp)°C")
                .font(.headline)
                .padding()

            Text("Feels Like: \(weatherData.main.feels_like)°C")
                .padding()

            Text("Conditions: \(weatherData.weather.first?.description ?? "N/A")")
                .padding()

            Text("Humidity: \(weatherData.main.humidity)%")
                .padding()

            Text("Wind Speed: \(weatherData.wind.speed) m/s")
                .padding()

            Spacer()
        }
        .padding()
    }
}
