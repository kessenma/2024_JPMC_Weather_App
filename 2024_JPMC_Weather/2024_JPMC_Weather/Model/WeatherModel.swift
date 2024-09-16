//
//  app/Model/WeatherModel.swift
//  2024_JPMC_Weather
//
//  Created by Kyle Essenmacher on 9/14/24.
//
import Foundation

struct WeatherModel: Codable {
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
    }

    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }

    struct Clouds: Codable {
        let all: Int
    }

    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let clouds: Clouds
    let name: String
    let cod: Int

    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }
}


struct CityCoordinates: Codable, Identifiable {
    let id = UUID() // Unique identifier for SwiftUI
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
    let local_names: [String: String]?

    // Use CodingKeys to exclude `id` from Codable conformance
    enum CodingKeys: String, CodingKey {
        case name, lat, lon, country, state, local_names
    }
}



