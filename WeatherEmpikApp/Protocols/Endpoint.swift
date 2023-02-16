//
//  Endpoint.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 12/02/2023.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
}


enum RequestMethod: String {
    case get = "GET"
    case put = "PUT"
}

extension Endpoint {
    var scheme: String {
        return "https"
    }

    var host: String {
        return "api.openweathermap.org"
    }
}
