//
//  ErrorView.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 14/02/2023.
//

import SwiftUI

struct ErrorView: View {
    @Binding var error: DisplayError
    
    var body: some View {
        Text(error.descriprion)
                .font(.footnote)
                .foregroundColor(.red)
    }
}
