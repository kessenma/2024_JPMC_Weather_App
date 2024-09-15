//
//  WeatherAPI.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/14/24.
//

import Foundation
import Combine

private enum APIKEY {
    static let key = "" // Enter your API KEY here
}

class WeatherAPI {
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func getWeather(for city: String) -> AnyPublisher<WeatherResponse, Error> {
        guard let url = URL(string: "\(baseURL)?q=\(city)&appid=\(APIKEY.key)&units=metric") else {
            fatalError("Invalid URL")
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
