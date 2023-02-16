//
//  String + Extension.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 11/02/2023.
//

import Foundation
import CoreLocation

extension String {
    //MARK: - Extension to convert "China mainland" -> "China"
    func removeExtraText() -> String {
        self.replacingOccurrences(of: "mainland", with: "")
    }
    
    //MARK: - Get coords from String
    func getCoord() -> CLLocationCoordinate2D {
        let arr = self.components(separatedBy: ",")
        guard
            let lat = Double(arr.first!),
            let long = Double(arr.last!)
        else {
            return CLLocationCoordinate2D.init()
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}

