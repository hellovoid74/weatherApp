//
//  ImageBundle.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 10/02/2023.
//

import SwiftUI

final class  ImageBundle {
    
    static func xmark() -> Image {
        Image(systemName: "xmark.circle.fill")
    }
    
    static func glass() -> Image {
        Image(systemName: "magnifyingglass")
    }
    
    static func sun() -> Image {
        Image(systemName: "sun.max")
    }
    
    static func sendButton() -> Image {
        Image(systemName: "location")
    }
    
    static func wind() -> Image {
        Image(systemName: "wind")
    }
    
    static func rain() -> Image {
        Image(systemName: "cloud.rain")
    }
    
    static func temp() -> Image {
        Image(systemName: "thermometer")
    }
    
    static func humidity() -> Image {
        Image(systemName: "drop.triangle")
    }
    
    static func sunriseUI() -> UIImage {
        UIImage(systemName: "sunrise") ?? UIImage()
    }
    
    static func sunsetUI() -> UIImage {
        UIImage(systemName: "sunset") ?? UIImage()
    }
    
    static func tempUI() -> UIImage {
        UIImage(systemName: "thermometer") ?? UIImage()
    }
    
    static func tempUImin() -> UIImage {
        UIImage(systemName: "thermometer.snowflake") ?? UIImage()
    }
    
    static func tempUImax() -> UIImage {
        UIImage(systemName: "thermometer.sun") ?? UIImage()
    }
    
    static func wind() -> UIImage {
        UIImage(systemName: "wind") ?? UIImage()
    }
    
    static func pressure() -> UIImage {
        UIImage(systemName: "purchased") ?? UIImage()
    }
    
    static func rainUI() -> UIImage {
        UIImage(systemName: "cloud.rain.fill") ?? UIImage()
    }
}

