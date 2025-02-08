//
//  IdentifierExtension.swift
//  Akakce Case Study IOS
//
//  Created by Mert Saygılı on 8.02.2025.
//

import UIKit

typealias ViewControllerIdentifier = UIViewController
typealias TableViewCellIdentifier = UITableViewCell
typealias CollectionViewCellIdentifier = UICollectionViewCell

extension ViewControllerIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

extension TableViewCellIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}

extension CollectionViewCellIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
}
