//
//  ContractTests.swift
//  2024_JPMC_WeatherAPITests
//
//  Created by Kyle Essenmacher on 9/16/24.
//


import XCTest
import Combine
@testable import _024_JPMC_Weather


// CityAPIProtocol.swift
protocol CityAPIProtocol {
    static func fetchCoordinates(for cityName: String, stateCode: String, countryCode: String) -> AnyPublisher<[CityCoordinates], Error>
}

// WeatherAPIProtocol.swift
protocol WeatherAPIProtocol {
    static func fetchWeather(latitude: Double, longitude: Double) -> AnyPublisher<WeatherModel, WeatherError>
}

// CityAPIContractTests.swift
// CityAPIContractTests.swift
// CityAPIContractTests.swift
class CityAPIContractTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []

    func testFetchCoordinatesResponse() {
        // Arrange
        let cityName = "New York"
        let stateCode = "NY"
        let countryCode = "US"

        // Mock CityAPI
        class MockCityAPI: CityAPIProtocol {
            static let expectedResponse = [CityCoordinates(name: "New York", lat: 40.7128, lon: -74.0060, country: "US", state: "NY", local_names: [:])]

            static func fetchCoordinates(for cityName: String, stateCode: String, countryCode: String) -> AnyPublisher<[CityCoordinates], Error> {
                Just(expectedResponse).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
        }

        // Act
        let publisher = MockCityAPI.fetchCoordinates(for: cityName, stateCode: stateCode, countryCode: countryCode)

        // Assert
        var receivedResponse: [CityCoordinates]?
        let expectation = XCTestExpectation(description: "Fetch coordinates response")
        publisher.sink(receiveCompletion: { _ in
            expectation.fulfill()
        }, receiveValue: { coordinates in#imageLiteral(resourceName: "simulator_screenshot_0D45FEA5-0940-426D-913D-BAFFD3569B63.png")
            receivedResponse = coordinates
        }).store(in: &self.cancellables)

        wait(for: [expectation], timeout: 5)

        XCTAssertEqual(receivedResponse, MockCityAPI.expectedResponse)
    }
}

// WeatherAPIContractTests.swift
class WeatherAPIContractTests: XCTestCase {
    var cancellables: Set<AnyCancellable> = []

    func testFetchWeatherResponse() {
        // Arrange
        let latitude = 40.7128
        let longitude = -74.0060

        // Mock WeatherAPI
        class MockWeatherAPI: WeatherAPIProtocol {
            static let expectedResponse = WeatherModel(coord: .init(lon: -74.0060, lat: 40.7128), weather: [.init(id: 800, main: "Clear", description: "clear sky", icon: "01d")], main: .init(temp: 20, feels_like: 18, temp_min: 15, temp_max: 25, pressure: 1013, humidity: 60), wind: .init(speed: 5, deg: 280), clouds: .init(all: 0), name: "New York", cod: 200)

            static func fetchWeather(latitude: Double, longitude: Double) -> AnyPublisher<WeatherModel, WeatherError> {
                Just(expectedResponse).setFailureType(to: WeatherError.self).eraseToAnyPublisher()
            }
        }

        // Act
        let publisher = MockWeatherAPI.fetchWeather(latitude: latitude, longitude: longitude)

        // Assert
        var receivedResponse: WeatherModel?
        let expectation = XCTestExpectation(description: "Fetch weather response")
        publisher.sink(receiveCompletion: { _ in
            expectation.fulfill()
        }, receiveValue: { weather in
            receivedResponse = weather
        }).store(in: &self.cancellables)

        wait(for: [expectation], timeout: 5)

        XCTAssertEqual(receivedResponse, MockWeatherAPI.expectedResponse)
    }
}
