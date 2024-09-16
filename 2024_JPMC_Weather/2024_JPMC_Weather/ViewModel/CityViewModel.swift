//
//  app/ViewModel/CityViewModel.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/16/24.
//

import SwiftUI
import Combine

class CityViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published var stateCode: String = ""
    @Published var countryCode: String = ""
    @Published var cityCoordinates: CityCoordinates?
    @Published var weatherData: WeatherModel?
    @Published var cityResults: [CityCoordinates] = []
    @Published var errorMessage: String?
    @Published var pastWeatherData: [String: WeatherModel] = [:]

    var cancellables = Set<AnyCancellable>()

    @ObservedObject var historyViewModel: HistoryViewModel
    
    init(historyViewModel: HistoryViewModel) {
        self.historyViewModel = historyViewModel
    }

    func searchCoordinates() {
        guard !cityName.isEmpty else {
            errorMessage = "Please enter a city name."
            return
        }

        CityAPI.fetchCoordinates(for: cityName, stateCode: stateCode, countryCode: countryCode)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = "Failed to fetch coordinates: \(error.localizedDescription)"
                }
            } receiveValue: { coordinates in
                if !coordinates.isEmpty {
                    self.cityResults = coordinates
                } else {
                    self.errorMessage = "No coordinates found for this location."
                }
            }
            .store(in: &cancellables)
    }

    func fetchWeather(for coordinates: CityCoordinates) {
        let cityNameKey = coordinates.name
        
        if let pastWeather = pastWeatherData[cityNameKey] {
            self.weatherData = pastWeather
            historyViewModel.saveSearch(city: coordinates.name)
            return
        }

        WeatherAPI.fetchWeather(latitude: coordinates.lat, longitude: coordinates.lon)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    self.errorMessage = "Failed to fetch weather data: \(error.localizedDescription)"
                }
            } receiveValue: { weather in
                self.weatherData = weather
                self.pastWeatherData[cityNameKey] = weather
                self.historyViewModel.saveSearch(city: coordinates.name)
            }
            .store(in: &cancellables)
    }
    
    func selectCity(_ coordinates: CityCoordinates) {
        self.cityCoordinates = coordinates
        fetchWeather(for: coordinates)
    }
}
