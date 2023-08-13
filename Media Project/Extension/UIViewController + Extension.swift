//
//  UIViewController.swift
//  Media Project
//
//  Created by 백래훈 on 2023/08/13.
//

import UIKit

extension UIViewController: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
}
