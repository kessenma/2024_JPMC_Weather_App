//
//  app/api/weatherAPI.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/14/24.
//
// once the app has a lat and long cordinate to search with I want to use this file to make the call to the API with this API formatting:
// GET: http://api.openweathermap.org/geo/1.0/reverse?lat=51.5098&lon=-0.1180&limit=5&appid=546270a7ad449f00a347299e8837e71b
// the key a the end is the API KET

import Foundation
import Combine

enum WeatherError: Error {
    case invalidURL
    case networkError(Error)
    case decodingError(Error)
}

class WeatherAPI {
    static func fetchWeather(latitude: Double, longitude: Double) -> AnyPublisher<WeatherModel, WeatherError> {
        guard let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String else {
            fatalError("API Key not found")
        }
        
        let urlString = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else {
            return Fail(error: WeatherError.invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { WeatherError.networkError($0) }
            .flatMap { data, _ -> AnyPublisher<WeatherModel, WeatherError> in
                let decoder = JSONDecoder()
                return Just(data)
                    .decode(type: WeatherModel.self, decoder: decoder)
                    .mapError { WeatherError.decodingError($0) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
