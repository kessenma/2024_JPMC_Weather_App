//
//  app/api/convert/cityAPI.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/15/24.
//

// i want this API call to convert a city to a lattitude and longitude coordinates that the API can digest

import Combine
import Foundation


class CityAPI {
    static func fetchCoordinates(for cityName: String, stateCode: String? = nil, countryCode: String? = nil) -> AnyPublisher<[CityCoordinates], Error> {
        // Replace spaces with underscores in the city name
        let formattedCityName = cityName.replacingOccurrences(of: " ", with: "_")
        
        // Start building the URL
        var urlString = "https://api.openweathermap.org/geo/1.0/direct?q=\(formattedCityName)&limit=5&appid=\(Env.apiKey)"
        
        // Append state code if available
        if let state = stateCode, !state.isEmpty {
            urlString += ",\(state)"
        }
        
        // Append country code if available
        if let country = countryCode, !country.isEmpty {
            urlString += ",\(country)"
        }

        // Output the URL for debugging
        print("URL being sent: \(urlString)")

        // Create the URL and perform the request
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [CityCoordinates].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
