//
//  SearchItemView.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 10/02/2023.
//

import SwiftUI

struct ListItemView: View {
    
    let item: CityModelElement

    var body: some View {
        let unicodeValue = Countries.getFlag(from: item.country)
        
            HStack {
                Text(unicodeValue)
                Text(item.createListNaming())
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
            }
            .padding()
    }
}

