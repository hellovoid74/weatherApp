//
//  FlowLayout.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 16/02/2023.
//

import UIKit

final class FlowLayout {
    
   static func layout() -> UICollectionViewCompositionalLayout {
       
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(150),
            heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize, subitem: item, count: 1)
        group.edgeSpacing = NSCollectionLayoutEdgeSpacing(
            leading: .fixed(12), top: .flexible(0),
            trailing: .fixed(12), bottom: .fixed(10))
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        let layout = UICollectionViewCompositionalLayout(
            section: section, configuration:config)
       
        return layout
    }
}

