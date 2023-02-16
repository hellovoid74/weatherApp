//
//  AnimationView.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 13/02/2023.
//

import Lottie
import UIKit

final class AnimationView: UIView {
    private let name: String

    init(name: String) {
        self.name = name
        super.init()
        configureAnimation()
    }
    
    private func configureAnimation() {
        let animationView = LottieAnimationView(name: name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5
        addSubview(animationView)
        animationView.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
