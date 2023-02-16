//
//  ProgressView.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 16/02/2023.
//
import UIKit


final class ProgressView: UIView {
    
    private let circle = CAShapeLayer()
    var isAnimating: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    private func configure() {
        frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        let circularPath = UIBezierPath(ovalIn: self.bounds)
        
        circle.path = circularPath.cgPath
        circle.fillColor = UIColor.clear.cgColor
        circle.strokeColor = UIColor.systemIndigo.cgColor
        circle.lineWidth = 8
        circle.strokeEnd = 0.5
        circle.lineCap = .round
        self.layer.addSublayer(circle)
    }
    
    func animate() {
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            options: .curveLinear) {
                self.transform = CGAffineTransform(rotationAngle: .pi)
            } completion: { completion in
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0,
                    options: .curveLinear) {
                        self.transform = CGAffineTransform(rotationAngle: 0)
                    } completion: { _ in
                        self.animate()
                    }
            }
        self.isAnimating = true
    }
}
