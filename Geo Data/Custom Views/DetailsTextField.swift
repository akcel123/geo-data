//
//  DetailsTextField.swift
//  Geo Data
//
//  Created by Денис Павлов on 25.05.2023.
//

import UIKit

class DetailsTextField: ProfileTextField {
    
    private let padding = UIEdgeInsets(top: 0, left: UIElementsParameters.heigh / 2, bottom: 0, right: 0)
    //MARK: - Initializers
    init(text: String) {
        super.init(frame: .zero)
        setupTextField(text: text)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Определяем контейнер текста
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
        
    }
    
    // определяем контейнер плейсхолдера
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    // определяем контейнер редактируемого текста
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: UIEdgeInsets(top: 12, left: 11, bottom: 11, right: bounds.width - 11 - 25))
    }
    
    
    //MARK: - private funcs
    private func setupTextField(text: String) {
        translatesAutoresizingMaskIntoConstraints = false
        self.text = text
        backgroundColor = .clear
        font = .systemFont(ofSize: 18)
        clearButtonMode = .whileEditing
        layer.cornerRadius = 24

        layer.borderWidth = 1
        layer.borderColor = UIElementsParameters.Color.thirdColor.cgColor
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
}

