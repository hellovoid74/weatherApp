//
//  WeatherForcast.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 16/02/2023.
//

import UIKit

struct WeatherForcast: Hashable {
    let temperature: Double
    let sunset: Date
    let sunrise: Date
    let humidity: String
    let windSpeed: String
    let conditionId: Int
    let day: Date
    let minTemp: Double
    let maxTemp: Double
    
    init(object: Daily) {
        self.temperature = (object.temp?.day ?? 0)
        self.sunset = (object.sunset)?.getDateFromStamp() ?? Date()
        self.sunrise = (object.sunrise)?.getDateFromStamp() ?? Date()
        self.humidity = String(object.humidity ?? 0) + " %"
        self.windSpeed = String(object.windSpeed ?? 0) + " m/s"
        self.conditionId = object.weather?.first?.id ?? 0
        self.day = (object.dt ?? 0).getDateFromStamp()
        self.minTemp = (object.temp?.min ?? 0)
        self.maxTemp = (object.temp?.max ?? 0)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...221:
            return "cloud.sun.bolt"
        case 222...232:
            return "cloud.bolt.rain"
        case 300...321, 500...501:
            return "cloud.drizzle"
        case 502,503:
            return "cloud.rain"
        case 504...531:
            return "cloud.heavyrain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801:
            return "cloud.sun" 
        case 802...804:
            return "cloud"
        default:
            return "sun.max"
        }
    }
    
    var color: UIColor {
        switch conditionId {
        case 200...232:
            return .systemIndigo
        case 300...321:
            return .darkText
        case 500...531:
            return .blue
        case 600...622:
            return .white
        case 701...781:
            return .gray
        case 800:
            return .yellow
        case 801...804:
            return .systemIndigo
        default:
            return .gray
        }
    }
}
