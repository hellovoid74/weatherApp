//
//  NSPredicate.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 14/02/2023.
//

import Foundation

extension NSPredicate {
    static let cityPredicate = NSPredicate(
        format: "SELF MATCHES %@",
        "^[a-zA-Z]+(?:[\\s-'.&/][a-zA-Z]+)*(?:[.|\\s])?(?:[\\(a-z\\)])*$"
    )
}
