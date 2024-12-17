//
//  WeatherService.swift
//  Weather
//
//  Created by Razvan Copaciu on 17.12.2024.
//

import Foundation
import Alamofire

class WeatherService {

    private let service: NetworkService = NetworkService()

    func getCurrentWeather(city: String) async throws -> Data {
        var parameters = Parameters()
        parameters["key"] = "fd186765a06e4b91ae9184923241612"
        parameters["q"] = city

        return try await service.task(url: APIPath.url(.getCurrentWeather), parameters: parameters, method: .get, encoding: URLEncoding.queryString)
    }
}

enum APIPath: String {
    case getCurrentWeather = "/current.json"

    static func url(_ path: APIPath) -> String {
        "https://api.weatherapi.com/v1\(path.rawValue)"
    }
}
