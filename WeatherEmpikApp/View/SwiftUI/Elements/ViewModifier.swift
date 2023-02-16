//
//  ViewModifier.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 09/02/2023.
//


import Foundation
import SwiftUI

struct RoundCorners: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}

struct BlackRounded: ViewModifier {
    func body(content: Content) -> some View {
        content.self
            .font(.title2)
            .foregroundColor(Color.white)
            .background(
                Color.black
                    .cornerRadius(17.5))
    }
}

struct OffCapitalization: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content.self
                .textInputAutocapitalization(.never)
        } else {
            content.self
                .autocapitalization(.none)
        }
    }
}

    

extension View {

    func roundCorners() -> some View {
        modifier(BlackRounded())
    }
    
    func noCapitalization() -> some View {
        modifier(OffCapitalization())
    }
}

