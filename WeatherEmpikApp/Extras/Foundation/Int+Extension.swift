//
//  Int+Extension.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 15/02/2023.
//

import Foundation

extension Int {
    func getDateFromStamp(timezone: TimeZone? = .current) -> Date {
        guard let timezone = timezone else {
            return Date()
        }

        let timezoneOffset = timezone.secondsFromGMT()
        let timezoneEpochOffset = (Double(self) + Double(timezoneOffset))
        return Date(timeIntervalSince1970: timezoneEpochOffset)
    }
}
