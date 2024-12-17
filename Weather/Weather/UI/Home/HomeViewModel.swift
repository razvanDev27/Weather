//
//  HomeViewModel.swift
//  Weather
//
//  Created by Razvan Copaciu on 17.12.2024.
//

import SwiftUI

@Observable class HomeViewModel {

    var isLoading: Bool = false
    var isError: Bool = false
    var error: CustomError? = nil
    var resultWeatherLocation: Weather? = nil
    var selectedWeatherLocation: Weather? = nil

    var searchText: String = ""
    var debouncedText: String = ""
    private let debounceActor = DebounceActor()

    private let weatherService: WeatherService = WeatherService()
    private var userDataProvider: UserDataProvider
    private let jsonDecoder: JSONDecoder = JSONDecoder()

    init(userDataProvider: UserDataProvider) {
        self.userDataProvider = userDataProvider

        getCachedWeatherLocation()
    }

    func updateDebouncedText() async {
        await debounceActor.debounce(for: 1.0) { [weak self] in
            guard let self, !searchText.isEmpty else { return }
            debouncedText = searchText
            search(city: debouncedText)
        }
    }

    func selectWeatherLocation(_ weatherLocation: Weather) {
        userDataProvider.userDefaults.weatherLocation = weatherLocation
        selectedWeatherLocation = weatherLocation
        resultWeatherLocation = nil
    }

    func search(city: String) {
        Task {
            resultWeatherLocation = await getWeatherForCity(city)
        }
    }

    func getWeatherForCity(_ city: String) async -> Weather? {
        var weatherLocation: Weather?

        isError = false
        isLoading = true
        do {
            let data = try await weatherService.getCurrentWeather(city: city)
            weatherLocation = try jsonDecoder.decode(Weather.self, from: data)
        } catch {
            self.error = CustomError(error)
            self.isError = true
        }
        isLoading = false

        return weatherLocation
    }

    // MARK: Private methods


    private func getCachedWeatherLocation() {
        guard let weatherLocation = userDataProvider.userDefaults.weatherLocation else {
            return
        }

        Task {
            selectedWeatherLocation = await getWeatherForCity(weatherLocation.location.name)
        }
    }

}
