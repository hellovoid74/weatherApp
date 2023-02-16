//
//  LocationManager.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 15/02/2023.
//

import Combine
import CoreLocation

enum LocationError: Error {
    case unauthorized, unableToDetermineLocation
}

final class LocationManager: NSObject, LocationServicable {
    private let locationManager = CLLocationManager()
    
    var authorisationRequests: [(Result<Void, LocationError>) -> Void] = []
    var locationRequests: [(Result<CLLocation, LocationError>) -> Void] = []
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestAuthInUse() -> Future<Void, LocationError> {
        guard locationManager.authorizationStatus == .notDetermined else {
            return Future { $0(.success(())) }
        }
        
        let future = Future<Void, LocationError> { completion in
            self.authorisationRequests.append(completion)
        }
        
        locationManager.requestWhenInUseAuthorization()
        
        return future
    }
    
    func requestLocation() -> Future<CLLocation, LocationError> {
        guard locationManager.authorizationStatus == .authorizedAlways ||
                locationManager.authorizationStatus == .authorizedWhenInUse
        else {
            return Future { ($0(.failure(LocationError.unauthorized))) }
        }
        
        let future = Future<CLLocation, LocationError> { completion in
            self.locationRequests.append(completion)
        }

        locationManager.requestLocation()
        
        return future
    }
    
    private func handleLocationRequestResult(_ result: Result<CLLocation, LocationError>) {
        while locationRequests.count > 0 {
            let request = locationRequests.removeFirst()
            request(result)
        }
    }
}


extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            handleLocationRequestResult(.success(location))
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let locationError: LocationError
        if let error = error as? CLError, error.code == .denied {
            locationError = .unauthorized
        } else {
            locationError = .unableToDetermineLocation
        }
        handleLocationRequestResult(.failure(locationError))
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        while authorisationRequests.count > 0 {
            let request = authorisationRequests.removeFirst()
            request(.success(()))
        }
    }
    
}
