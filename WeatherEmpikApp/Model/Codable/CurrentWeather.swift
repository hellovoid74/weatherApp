
import Foundation

// MARK: - CurrentWeather
struct CurrentWeather: Codable {
    var lat, lon: Double?
    var timezone: String?
    var timezoneOffset: Int?
    var current: Current?
    var minutely: [Minutely]?
    var hourly: [Current]?
    var alerts: [Alert]?
    var daily: [Daily]?

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, minutely, hourly, daily, alerts
    }
}

// MARK: - Current
struct Current: Codable {
    var dt, sunrise, sunset: Int?
    var temp, feelsLike: Double?
    var pressure, humidity: Int?
    var dewPoint, uvi: Double?
    var clouds, visibility: Int?
    var windSpeed: Double?
    var windDeg: Int?
    var windGust: Double?
    var weather: [Weather]?
    var rain: Rain?
    var pop: Double?
    var snow: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case uvi, clouds, visibility
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, rain, pop, snow
    }
}

// MARK: - Rain
struct Rain: Codable {
    var the1H: Double?

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Weather
struct Weather: Codable {
    var id: Int?
    var main: Main?
    var description, icon: String?
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case fewClouds = "few clouds"
    case haze = "haze"
    case lightRain = "light rain"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
    case fog = "fog"
    case smoke = "smoke"
}

enum Main: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
    case haze = "Haze"
    case mist = "Mist"
    case fog = "Fog"
    case smoke = "Smoke"
}

// MARK: - Daily
struct Daily: Codable {
    var dt, sunrise, sunset, moonrise: Int?
    var moonset: Int?
    var moonPhase: Double?
    var temp: Temp?
    var feelsLike: FeelsLike?
    var pressure, humidity: Int?
    var dewPoint, windSpeed: Double?
    var windDeg: Int?
    var windGust: Double?
    var weather: [Weather]?
    var clouds: Int?
    var pop, rain, uvi, snow: Double?

    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case temp
        case feelsLike = "feels_like"
        case pressure, humidity
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
        case windGust = "wind_gust"
        case weather, clouds, pop, rain, uvi, snow
    }
}

// MARK: - FeelsLike
struct FeelsLike: Codable {
    var day, night, eve, morn: Double?
}

// MARK: - Temp
struct Temp: Codable {
    var day, min, max, night: Double?
    var eve, morn: Double?
}

// MARK: - Minutely
struct Minutely: Codable {
    var dt: Int?
    var precipitation: Double?
}

// MARK: - Alert
struct Alert: Codable {
    var senderName: String?
    var event: String?
    var start, end: Int?
    var description: String?
    var tags: [String]?

    enum CodingKeys: String, CodingKey {
        case senderName = "sender_name"
        case event, start, end, description, tags
    }
}

// MARK: - Empty
struct Empty: Codable {
    var lat, lon: Double?
    var timezone: String?
    var timezoneOffset: Int?
    var current: Current?
    var minutely: [Minutely]?
    var hourly: [Current]?
    var daily: [Daily]?
    var alerts: [Alert]?

    enum CodingKeys: String, CodingKey {
        case lat, lon, timezone
        case timezoneOffset = "timezone_offset"
        case current, minutely, hourly, daily, alerts
    }
}

enum Tag: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case fog = "Fog"
    case rain = "Rain"
}

