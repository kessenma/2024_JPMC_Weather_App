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
    @Published var errorMessage: String?

    var cancellables = Set<AnyCancellable>()

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
                if let firstCoordinate = coordinates.first {
                    // Validate latitude and longitude are not NaN
                    if !firstCoordinate.lat.isNaN && !firstCoordinate.lon.isNaN {
                        self.cityCoordinates = firstCoordinate
                    } else {
                        self.errorMessage = "Invalid coordinates received."
                    }
                } else {
                    self.errorMessage = "No coordinates found for this location."
                }
            }
            .store(in: &cancellables)
    }
}
