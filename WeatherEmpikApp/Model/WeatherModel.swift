//
//  WeatherModel.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 12/02/2023.
//

import Foundation
import SwiftUI

enum DayTime {
    case day, night
}

struct WeatherModel: Hashable {
    
    let dayTime: DayTime
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let time: String
    let windSpeed: String
    let precipitation: String
    let sunset: Date
    let sunrise: Date
    let humidity: String
    let pressure: String
    let dailyForcast: [WeatherForcast]?
    
    init(object: CurrentWeather, name: String) {
        self.cityName = name
        self.conditionId = object.current?.weather?.first?.id ?? 0
        self.temperature = object.current?.temp ?? 0
        self.time = Date().getProperDate(timezone: object.timezone)
        self.windSpeed = String(object.current?.windSpeed ?? 0) + " m/s"
        self.precipitation = String(format: "%.0f", (((object.hourly?.first?.pop ?? 0) * 100))) + " %"
        self.sunset = (object.current?.sunset ?? 0).getDateFromStamp()
        self.sunrise = (object.current?.sunrise ?? 0).getDateFromStamp()
        self.dayTime = Date().getDayTime(timezone: object.timezone ?? "", sunrise: sunrise, sunset: sunset)
        self.humidity = String(object.current?.humidity ?? 0) + " %"
        self.pressure = String(object.current?.pressure ?? 0) + " hPa"
        self.dailyForcast = object.daily?.compactMap { WeatherForcast(object: $0) }
    }
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var animationName: String {
        switch conditionId {
        case 200...221:
            return "thunder"
        case 222...232:
            return "storm"
        case 300...321:
            return self.dayTime == .day ? "rain.day" : "rain.night"
        case 500...501:
            return self.dayTime == .day ? "rain.day" : "rain.night"
        case 502...531:
            return "storm"
        case 600...601:
            return self.dayTime == .day ? "snow.day" : "snow.night"
        case 602...622:
            return "snow"
        case 701...781:
            return "mist"
        case 800:
            return self.dayTime == .day ? "clear.day" : "clear.night"
        case 801:
            return self.dayTime == .day ? "cloudy.day" : "cloudy.night"
        case 802...804:
            return "cloud"
        default:
            return self.dayTime == .day ? "clear.day" : "clear.night"
        }
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...221:
            return self.dayTime == .day ? "cloud.sun.bolt" : "cloud.moon.bolt"
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
            return self.dayTime == .day ? "sun.max" : "moon.stars"
        case 801:
            return self.dayTime == .day ? "cloud.sun" : "cloud.moon"
        case 802...804:
            return "cloud"
        default:
            return self.dayTime == .day ? "sun.max" : "moon.stars"
        }
    }
    
    var color: Color {
        switch conditionId {
        case 200...232:
            return .indigo
        case 300...321:
            return .teal
        case 500...531:
            return .blue
        case 600...622:
            return .white
        case 701...781:
            return .gray
        case 800:
            return .yellow
        case 801...804:
            return .indigo
        default:
            return .gray
        }
    }
}

extension WeatherModel {
    func getEmpty() -> WeatherModel {
        WeatherModel(object: CurrentWeather(), name: "")
    }
}

