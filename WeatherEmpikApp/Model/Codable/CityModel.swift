//
//  CityModel.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 09/02/2023.
//

import Foundation

// MARK: - CityModelElement
struct CityModelElement: Codable, Hashable {
    let name: String
    let localNames: [String: String]?
    let lat, lon: Double
    let country: String
    let state: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}

typealias CityModel = [CityModelElement]

extension CityModelElement {
    func createListNaming() -> String {
        let state = self.state == nil ? "" : (", " + (self.state ?? ""))
        return self.name + ", " + (Countries.dictionary[self.country] ?? "").removeExtraText() + state
    }
    
    func emptyItem() -> CityModelElement {
        return .init(name: "", localNames: [:], lat: 0, lon: 0, country: "", state: "")
    }
}
