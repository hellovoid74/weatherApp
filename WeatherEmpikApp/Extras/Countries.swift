//
//  Countries.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 10/02/2023.
//

import Foundation

final class Countries {

    //MARK: - Zipping contry shortnames and names
    static var dictionary: [String: String] {
        let codes = Locale.isoRegionCodes

        let coountryList = codes.compactMap {
            Locale.current.localizedString(forRegionCode: $0)
        }
        
        return Dictionary(uniqueKeysWithValues: zip(codes, coountryList))
    }
    
    //MARK: - Get unicode value with country flag
    static func getFlag(from country:String) -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in country.uppercased().unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return s
    }
}
