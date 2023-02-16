//
//  ButtonStyle.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 15/02/2023.
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(Capsule()
            .foregroundColor(configuration.isPressed ? Color.primary.opacity(0.75) : Color.primary))
            .scaleEffect(configuration.isPressed ? 1.3 : 0.85)
            .blur(radius: configuration.isPressed ? CGFloat(0.0) : 0)
            .animation(Animation.spring(response: 0.9, dampingFraction: 0.9, blendDuration: 0.1))
    }
}

extension Button {
    func myButtonStyle() -> some View {
        self.buttonStyle(MyButtonStyle())
    }
}
