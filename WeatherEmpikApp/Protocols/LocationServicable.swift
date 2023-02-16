//
//  LocationServiceProtocol.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 16/02/2023.
//

import CoreLocation
import Combine

protocol LocationServicable {
    var authorisationRequests: [(Result<Void, LocationError>) -> Void] { get set }
    var locationRequests: [(Result<CLLocation, LocationError>) -> Void] { get set }
    func requestAuthInUse() -> Future<Void, LocationError>
    func requestLocation() -> Future<CLLocation, LocationError>
}
