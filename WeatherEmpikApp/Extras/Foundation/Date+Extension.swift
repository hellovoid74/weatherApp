//
//  Date+Extension.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 14/02/2023.
//

import Foundation

extension Date
{
    func toString(format: String = "HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func getProperDate(timezone: String?) -> String {
        let date = Date()
        var format = Date.FormatStyle.dateTime
        guard let zone = TimeZone(identifier: timezone ?? "") else {
            return Date().toString()
        }
        format.timeZone = zone
        return (date.formatted(format))
    }
    
    func getDayTime(timezone: String, sunrise: Date, sunset: Date) -> DayTime {
        let currentDate = Date()
        
        guard let zone = TimeZone(identifier: timezone) else { return .day }
        let timezoneOffset =  zone.secondsFromGMT()
        let epochDate = currentDate.timeIntervalSince1970
        let timezoneEpochOffset = (epochDate + Double(timezoneOffset))
        let resultDate = Date(timeIntervalSince1970: timezoneEpochOffset)
        let previousMidnight = Calendar.current.startOfDay(for: resultDate)
        
        return (resultDate >= previousMidnight && resultDate < sunrise) ||
        resultDate > sunset ? .night : .day
    }
    
    func getWeekDay() -> String {
        let today = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return self == today ? "Today" : dateFormatter.string(from: self)
    }
}
