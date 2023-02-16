//
//  View+Extension.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 16/02/2023.
//

import UIKit

extension UIView {
    func roundCorners(corners: UIRectCorner = [.allCorners], radius: CGFloat) {
        let cornerRadii = CGSize(width: radius, height: radius)
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UILabel {
    func addTextToLabel(string: String, image: UIImage, color: UIColor) -> UILabel {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image.withTintColor(color)
        let fullString = NSMutableAttributedString(string: "")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        fullString.append(NSAttributedString(string: " \(string)"))
        self.attributedText = fullString
        return self
    }
}
