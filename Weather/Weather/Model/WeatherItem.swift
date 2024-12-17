//
//  Item.swift
//  Weather
//
//  Created by Razvan Copaciu on 17.12.2024.
//

import Foundation

struct Weather: Codable {
    let location: WeatherLocation
    var current: WeatherCurrent
}

struct WeatherLocation: Codable {
    let name: String
    let region: String
}

struct WeatherCurrent: Codable {
    let temperature: Double
    let humidity: Double
    let condition: WeatherCondition
    let uv: Double
    let temperatureFeelsLike: Double

    enum CodingKeys: String, CodingKey {
        case humidity, condition, uv
        case temperature = "temp_c"
        case temperatureFeelsLike = "feelslike_c"
    }
}

struct WeatherCondition: Codable {
    let icon: String
}
