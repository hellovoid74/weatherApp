//
//  ItemViewModel.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 12/02/2023.
//

import Foundation
import Combine
import CoreLocation

final class ItemViewModel: ObservableObject {
    
    let item: CityModelElement
    let service: WeatherServicable
    let storage: LocalStorage
    @Published var weatherModel: WeatherModel?
    @Published var model: CurrentWeather?
    
    init(selectedCity: CityModelElement,
         service: WeatherServicable = WeatherService(),
         storage: LocalStorage = LocalStorage()
    ) {
        self.item = selectedCity
        self.service = service
        self.storage = storage
        _ = storage.readData()
    }
    
    func weatherRequest(copmletion: @escaping ((Result<WeatherModel, Error>) -> Void)) {
        storeSelectedPlace()
        service.getWeather(
            coordinates: CLLocationCoordinate2D(
                latitude: item.lat, longitude: item.lon)
        ) { [unowned self]  result in
            switch result {
            case .success(let receivedData):
                copmletion(.success(WeatherModel(object: receivedData, name: self.item.name)))
            case .failure(let error):
                copmletion(.failure(error))
            }
        }
    }
    
    private func storeSelectedPlace() {
        storage.updateData(
            city: item.name,
            coord: CLLocationCoordinate2D(
                latitude: item.lat,
                longitude: item.lon
            )
        )
    }
}
