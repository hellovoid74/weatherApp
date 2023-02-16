//
//  NetworkService.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 09/02/2023.
//

import Foundation
import Combine
import CoreLocation

@frozen enum APIConstants {
    static let key = "c7c5f9c1e353a8d7bf0c3781bc596d30"
    static let name = "/geo/1.0/direct"
    static let reverse = "/geo/1.0/reverse"
    static let weather = "/data/3.0/onecall"
}

enum WeatherAppEndPoint {
    case nameSearch(name: String)
    case reverseSearch(coords: CLLocationCoordinate2D)
    case weatherSearch(coords: CLLocationCoordinate2D)
}

extension WeatherAppEndPoint: Endpoint {
    var path: String {
        switch self {
        case .nameSearch:
            return APIConstants.name
        case .reverseSearch:
            return APIConstants.reverse
        case .weatherSearch:
            return APIConstants.weather
        }
    }
    
    var method: RequestMethod { .get }
    
    var header: [String: String]? {
        switch self {
        case .nameSearch(let name):
            return ["q": name,
                    "appid": APIConstants.key,
                    "limit": String(10)
            ]
        case .reverseSearch(coords: let coord):
            return ["lat": String(coord.latitude),
                    "lon": String(coord.longitude),
                    "appid": APIConstants.key,
                    "limit": String(1)
            ]
            
        case .weatherSearch(let coords):
            return [
                "lat": String(coords.latitude),
                "lon": String(coords.longitude),
                "appid": APIConstants.key,
                "units": "metric"
            ]
        }
    }
    
    var body: [String : String]? {
        return nil
    }
}

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case invalidURL
    case decodingError
    case unknown
    case error(err: String)
}

struct WeatherService: HTTPClient, WeatherServicable {
    
    //MARK: - Search location by provided name
    func getLocation(
        query: String,
        completion: @escaping (Result<CityModel, NetworkError>
        ) -> Void) {
        sendRequest(
            endpoint: WeatherAppEndPoint.nameSearch(name: query),
            responseModel: CityModel.self
        ) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    //MARK: - Search weather by received location
    func getWeather(
        coordinates: CLLocationCoordinate2D,
        completion: @escaping (Result<CurrentWeather, NetworkError>) -> Void) {
        sendRequest(
            endpoint: WeatherAppEndPoint.weatherSearch(coords: coordinates),
            responseModel: CurrentWeather.self
        ) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Search location name by coords
    func reverseSearch(
        coordinates: CLLocationCoordinate2D,
        completion: @escaping ((Result<[CityModelElement], NetworkError>) -> Void))
    {
        sendRequest(
            endpoint: WeatherAppEndPoint.reverseSearch(coords: coordinates),
            responseModel: [CityModelElement].self
        ) { result in
            switch result {
            case .success(let model):
                completion(.success(model))
            case .failure:
                completion(.failure(.invalidResponse))
            }
        }
        
    }
}
