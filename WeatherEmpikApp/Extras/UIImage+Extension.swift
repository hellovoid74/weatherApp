//
//  UIImage.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 16/02/2023.
//

import UIKit

extension UIImage {
    static func gradientImage(bounds: CGRect, colors: [UIColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map(\.cgColor)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        
        return renderer.image { ctx in
            gradientLayer.render(in: ctx.cgContext)
        }
    }
    
    static func getGradientColor(
        frame: CGRect,
        color1: UIColor,
        color2: UIColor) -> UIColor {
            let gradient = UIImage.gradientImage(
                bounds: frame,
                colors: [UIColor.violet, UIColor.cobalt]
            )
            return UIColor(patternImage: gradient)
        }
}
