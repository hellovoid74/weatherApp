//
//  ClearableTextField.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 11/02/2023.
//

import SwiftUI

struct ClearableTextField: View {
    
    var title: String
    @Binding var text: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        _text = text
    }
    
    var body: some View {
        ZStack(alignment: .trailing) {
            TextField(title, text: $text)
                .disableAutocorrection(true)
            if text.count > 0 {
                ImageBundle.xmark()
                    .foregroundColor(.secondary)
                    .onTapGesture {
                        text = ""
                    }
            }
        }
    }
}
