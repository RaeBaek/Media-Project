//
//  UICollectionViewCell + Extension.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/14.
//

import UIKit

extension UICollectionViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
