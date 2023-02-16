//
//  Array + Extension.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 10/02/2023.
//

import Foundation

//MARK: - Extension to remove not unique elemenets in array buy certain property
extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>()
        var arrayOrdered = [Element]()
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
}
