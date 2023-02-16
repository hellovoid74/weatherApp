//
//  Int+Extension.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 15/02/2023.
//

import Foundation

extension Int {
    func getDateFromStamp() -> Date {
        return Date(timeIntervalSince1970: Double(self))
    }
}
