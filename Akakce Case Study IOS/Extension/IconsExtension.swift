//
//  AppIconExtension.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 8.02.2025.
//

import UIKit

typealias IconsExtension = UIImage

extension IconsExtension {
    var fillStarImage: UIImage {
        return UIImage(systemName: "star.fill") ?? UIImage()
    }

    var halfStarImage: UIImage {
        return UIImage(systemName: "star.leadinghalf.fill") ?? UIImage()
    }

    var emptyStarImage: UIImage {
        return UIImage(systemName: "star") ?? UIImage()
    }
}
