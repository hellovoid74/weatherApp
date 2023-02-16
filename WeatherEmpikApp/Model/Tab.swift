//
//  Tab.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 13/02/2023.
//

import Foundation

struct Tab: Identifiable, Hashable {
    var id = UUID().uuidString
    var item: WeatherModel
}
