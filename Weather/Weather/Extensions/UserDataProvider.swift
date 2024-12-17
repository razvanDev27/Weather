//
//  UserDataProvider.swift
//  Weather
//
//  Created by Razvan Copaciu on 17.12.2024.
//

import Foundation
import Combine

@Observable
final class UserDataProvider {
    let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
}

extension UserDefaults {
    var weatherLocation: Weather? {
        set {
            saveData(value: newValue, forKey: UserDefaultsKeys.weatherLocation)
        }
        get {
            getDataObject(type: Weather.self, forKey: UserDefaultsKeys.weatherLocation)
        }
    }
}

extension UserDefaults {
    private func saveData<T: Codable>(value: T?, forKey key: String) {
        let data = value != nil ? try? PropertyListEncoder().encode(value) : nil
        set(data, forKey: key)
    }

    private func getDataObject<T: Codable>(type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data {
            return try? PropertyListDecoder().decode(type, from: data)
        }
        return nil
    }
}

struct UserDefaultsKeys {
    static let weatherLocation = "UserDefaultsKeysWeatherLocation"
}
