//
//  LocalStorage.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 14/02/2023.
//

import Foundation
import CoreLocation

enum StorageConstants {
    static let mainKey = "cities"
    static let defaultCities = [
        "Warsaw": "52.2337172,21.071432235636493",
        "London": "51.5073219,-0.1276474",
        "Tokyo": "35.6828387,139.7594549"
    ]
}

final class LocalStorage {
    private let standart = UserDefaults.standard
    
    func readData() -> [String: String] {
        guard let dict = standart.object(
            forKey: StorageConstants.mainKey
        ) as? [String: String] else {
            return loadData()
        }
        return dict
    }
    
    func updateData(city: String, coord: CLLocationCoordinate2D) {
        var dict = readData()
        
        if dict.count > 12, let key = dict.randomElement()?.key {
            dict.removeValue(forKey: key)
        }
        
        dict.updateValue("\(coord.latitude),\(coord.longitude)", forKey: city)
        standart.set(dict, forKey: StorageConstants.mainKey)
    }
    
    
    func loadData() -> [String: String] {
        standart.set(
            StorageConstants.defaultCities,
            forKey: StorageConstants.mainKey)
        
        return StorageConstants.defaultCities
    }
    
    func clearDict() {
        standart.set([], forKey: StorageConstants.mainKey)
    }
}
