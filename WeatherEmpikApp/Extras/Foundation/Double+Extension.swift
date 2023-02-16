//
//  Double+Extension.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 14/02/2023.
//

import SwiftUI

extension Double {
    func getTemperature(withSign: Bool = true) -> String {
        let sign = withSign ? "° C" : "°"
        return String(format: "%.1f", self) + sign
    }
    
    func getColor() -> Color {
        switch self {
        case -1000..<10:
            return .blue
        case 10..<20:
            return .black
        case 20...10000:
            return .red
        default:
            return .green
        }
    }
    
    func getUIColor() -> UIColor {
        switch self {
        case -1000..<10:
            return .systemBlue
        case 10..<20:
            return .black
        case 20...10000:
            return .red
        default:
            return .green
        }
    }
}
