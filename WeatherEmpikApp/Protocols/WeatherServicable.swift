//
//  WeatherServicable.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 16/02/2023.
//

import CoreLocation

protocol WeatherServicable {
    func getLocation(query: String, completion: @escaping (Result<CityModel, NetworkError>) -> Void)
    func getWeather(coordinates: CLLocationCoordinate2D, completion: @escaping (Result<CurrentWeather, NetworkError>) -> Void)
    func reverseSearch(coordinates: CLLocationCoordinate2D, completion: @escaping ((Result<[CityModelElement], NetworkError>) -> Void))
}
