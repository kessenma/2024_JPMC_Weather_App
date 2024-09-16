//
//  app/Model/WeatherModel.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/14/24.
//

struct WeatherModel: Codable {
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather: Codable {
    let description: String
}

struct Main: Codable {
    let temp: Double
}


struct CityCoordinates: Codable {
    let lat: Double
    let lon: Double
}




