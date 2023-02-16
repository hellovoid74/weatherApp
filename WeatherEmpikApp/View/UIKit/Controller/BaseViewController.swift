//
//  BaseViewController.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 16/02/2023.
//

import Foundation

import UIKit

protocol ProgressShowable {
    func showProgress()
    func hideProgress()
}

class BaseViewController: UIViewController {
    
    private var isAnimating: Bool
    
    enum BaseVcCosntants {
        
        static let activityFrame = CGRect(
            x: 0, y: 0,
            width: 80,
            height: 80
        )
        
        static let loadingViewFrame = CGRect(
            x: 0, y: 0,
            width: 100,
            height: 100
        )
        static let fullFrame = CGRect(
            x: 0, y: 0,
            width: UIScreen.main.bounds.width,
            height: UIScreen.main.bounds.height
        )
        
        static let cornerRadius: CGFloat = 10
    }
    
    private let loadingView: UIView = {
        let view = UIView(frame: BaseVcCosntants.loadingViewFrame)
        view.clipsToBounds = true
        view.layer.cornerRadius = BaseVcCosntants.cornerRadius
        view.backgroundColor = UIColor.darkGray
        view.alpha = 1
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView(frame: BaseVcCosntants.fullFrame)
        view.backgroundColor = UIColor.clear
        view.alpha = 0.7
        return view
    }()
    
    lazy var animatingView: ProgressView = {
        let view = ProgressView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        return view
    }()
    
    init(isAnimating: Bool = false) {
        self.isAnimating = isAnimating
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setConstraints() {
        loadingView.center = CGPoint(
            x: UIScreen.main.bounds.width / 2,
            y: UIScreen.main.bounds.height / 2
        )
        
        containerView.addSubview(animatingView)
        animatingView.center = loadingView.center
        view.addSubview(containerView)
    }
}

extension BaseViewController: ProgressShowable {
    func showProgress() {
        setConstraints()
        if !isAnimating {
            animatingView.animate()
            isAnimating = true
        }
    }
    
    func hideProgress() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
        }
    }
}
