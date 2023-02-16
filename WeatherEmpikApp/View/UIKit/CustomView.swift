//
//  CustomView.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 16/02/2023.
//

import UIKit

final class CustomView: UIView {

    let image: UIImage
    let color: UIColor
    let string: String
    
    lazy var label: UILabel = {
       let label = UILabel()
        return label
    }()
    
    init(
        frame: CGRect,
        image: UIImage,
        color: UIColor,
        string: String
    ) {
        self.color = color
        self.image = image
        self.string = string
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image.withTintColor(color)

        let fullString = NSMutableAttributedString(string: "")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        fullString.append(NSAttributedString(string: string))
        label.attributedText = fullString
    }
}
