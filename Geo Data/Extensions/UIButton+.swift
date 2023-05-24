//
//  UIButton+.swift
//  Geo Data
//
//  Created by Денис Павлов on 24.05.2023.
//

import UIKit

extension UIButton {
    func createButtonWithTitle(_ title: String, backgroundColor: UIColor) -> Self {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = CGFloat(UIElementsParameters.heigh / 2)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 24)
        self.backgroundColor = backgroundColor
        return self
    }
}
