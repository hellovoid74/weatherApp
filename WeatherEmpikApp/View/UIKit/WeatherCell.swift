//
//  WeatherCell.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 16/02/2023.
//

import Foundation

import UIKit

enum WeatherCellConstants {
    static let id: String = "WeatherCellIdentifier"
}

final class WeatherViewCell: UICollectionViewCell {
    
    static let identifier = WeatherCellConstants.id
    
    lazy var background: UIImageView = {
        let image = UIImage.gradientImage(
            bounds: contentView.bounds,
            colors: [UIColor.violet, UIColor.cobalt]
        )
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .center
        view.distribution = .fillProportionally
        view.spacing = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        let view = UIImageView(frame: frame)
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    lazy var tempLabel: UILabel = {
        let label = UILabel()
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = ImageBundle.tempUImax().withTintColor(.systemRed)
        label.attributedText = (NSAttributedString(attachment: imageAttachment))
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    lazy var minTempLabel: UILabel = {
        let label = UILabel()
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = ImageBundle.tempUImin().withTintColor(.systemBlue)
        label.attributedText = (NSAttributedString(attachment: imageAttachment))
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    lazy var dayLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .medium)
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.2
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.roundCorners(radius: 12)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .clear
        setUpLayout()
    }
    
    private func setUpLayout() {
        contentView.addSubview(background)
        background.addSubview(stackView)
        
        [dayLabel, tempLabel, minTempLabel, imageView].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            background.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            background.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            background.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
}
