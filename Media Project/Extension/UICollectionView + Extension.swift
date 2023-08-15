//
//  UICollectionView + Extension.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/14.
//

import UIKit

extension UICollectionView: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
