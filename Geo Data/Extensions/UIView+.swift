//
//  UIView+.swift
//  Geo Data
//
//  Created by Денис Павлов on 20.03.2023.
//

import UIKit

extension UIView {
    func addSubviews(subviews: [UIView]) {
        for view in subviews {
            self.addSubview(view)
        }
    }
}
