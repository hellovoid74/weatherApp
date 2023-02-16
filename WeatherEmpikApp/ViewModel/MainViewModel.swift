//
//  MainViewModel.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 09/02/2023.
//

import Foundation
import Combine

enum DisplayError {
    case invalid, noresults, none
    
    var descriprion: String {
        switch self {
        case .invalid:
            return "Please type a correct city name"
        case .noresults:
            return "No results matching your request"
        case .none:
            return ""
        }
    }
}

final class MainViewModel: ObservableObject {
    
    let service: WeatherServicable
    let locationManager: LocationServicable
    private let storage: LocalStorage
    private var cancellables = Set<AnyCancellable>()
    @Published var searchText: String = ""
    @Published var searchResults: CityModel = []
    
    @Published var tabs: [Tab] = []
    @Published var isValid = true
    @Published var didStartTyping = false
    @Published var showCarousel = true
    @Published var isKeyBoardOpen = false
    @Published var error: DisplayError = .none
    
    init(service: WeatherServicable = WeatherService(),
         locationManager: LocationServicable = LocationManager(),
         storage: LocalStorage = LocalStorage()
    ) {
        self.service = service
        self.locationManager = locationManager
        self.storage = storage
        initializeValidation()
        shouldShowCarouselView()
        loadTabs()
        updateTimer()
        
        $searchText
            .debounce(for: 0.7, scheduler: RunLoop.main)
            .sink(receiveValue: { [unowned self] _ in
                guard isValid && didStartTyping else { return }
                
                service.getLocation(query: self.searchText) { result in
                    switch result {
                    case .success(let model):
                        DispatchQueue.main.async {
        
                            self.searchResults = model.unique {$0.state}
                            if model.isEmpty {
                                self.error = .noresults
                            }
                        }
                    case .failure:
                        break
                    }
                }
            })
            .store(in: &cancellables)
    }
    
    //MARK: - Set Validation
    private func initializeValidation() {
        $searchText
            .map { email in
                return NSPredicate.cityPredicate.evaluate(with: self.searchText)
            }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellables)
        
        $searchText
            .map {
                $0.count > 0
            }
            .assign(to: \.didStartTyping, on: self)
            .store(in: &cancellables)
        
        Publishers.CombineLatest($isValid, $didStartTyping)
            .map { valid, started in
                return !valid && started ? .invalid : .none
            }
            .assign(to: \.error, on: self)
            .store(in: &cancellables)
        
        $error
            .sink { error in
                self.searchResults = error == .none ? self.searchResults : []
            }
            .store(in: &cancellables)
       
        $didStartTyping
            .sink { didStartTyping in
                self.searchResults = didStartTyping ? self.searchResults : []
            }
            .store(in: &cancellables)
    }
    
    //MARK: - Set publisher to hide CarouselView when keyboard is open or typing in proccess
    private func shouldShowCarouselView() {
        Publishers.CombineLatest($isKeyBoardOpen, $didStartTyping)
            .map {
                keyboardOpen, typing in
                return !(keyboardOpen || typing)
            }
            .assign(to: \.showCarousel, on: self)
            .store(in: &cancellables)
    }
    
    //MARK: - Set timer publisher to update Tabs each new minute
    private func updateTimer() {
        _ = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            let second = Calendar.current.component(.second, from: Date())
            if second == 0 {
                self.loadTabs()
            }
        }
    }
    
    //MARK: - Load searched cities from local storage and send requests
    private func loadTabs() {
        let dict = storage.readData()
        
        dict.forEach {
            let coords = $0.value.getCoord(), city = $0.key
            service.getWeather(coordinates: coords) { [unowned self] result in
                switch result {
                case .success(let received):
                    let model = WeatherModel(object: received, name: city)
                    DispatchQueue.main.async {
                        if let index = self.tabs.firstIndex( where: {$0.item.cityName == model.cityName} ) {
                            self.tabs[index] = Tab(item: model)
                        } else {
                            self.tabs.append(Tab(item: model))
                        }
                    }
                case .failure:
                    break
                }
            }
        }
    }
    
    //MARK: - Location request
    func requestLocation() {
        locationManager.requestAuthInUse()
            .flatMap { self.locationManager.requestLocation() }
            .sink { comprtion in
                print(comprtion)
            } receiveValue: { [unowned self] location in
                service.reverseSearch(coordinates: location.coordinate) { result in
                    if case .success(let array) = result {
                        guard let cityName = array.first?.name else { return }
                        DispatchQueue.main.async {
                            self.searchText = cityName
                        }
                        
                    }
                }
            }
            .store(in: &cancellables)
    }
}
