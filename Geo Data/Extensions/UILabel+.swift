//
//  UILabel+.swift
//  Geo Data
//
//  Created by Денис Павлов on 24.05.2023.
//

import UIKit

extension UILabel {
    func createEmptyTextFieldLabel(text: String) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 0
        self.text = text
        self.font = UIFont.systemFont(ofSize: 14)
        return self
    }
    
    func createLabelWithText(_ text: String?) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        self.text = text ?? ""
        return self
    }
}
