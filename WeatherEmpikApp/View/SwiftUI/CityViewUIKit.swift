//
//  CityViewUIKit.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 13/02/2023.
//

import Foundation
import SwiftUI
//

struct CityViewUIKit: UIViewControllerRepresentable {
    typealias UIViewControllerType = ForecastViewController
    var city: CityModelElement
    
    func makeUIViewController(context: Context) -> ForecastViewController {
        let viewModel = ItemViewModel(selectedCity: city)
        let vc = ForecastViewController(viewModel: viewModel)
        return vc
    }
    
    func updateUIViewController(_ uiViewController: ForecastViewController, context: Context) {

    }
}
