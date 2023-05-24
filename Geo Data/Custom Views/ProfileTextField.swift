//
//  ProfileTextField.swift
//  Geo Data
//
//  Created by Денис Павлов on 24.05.2023.
//

import UIKit

class ProfileTextField: UITextField {

    private let padding = UIEdgeInsets(top: 0, left: 41, bottom: 0, right: 40)
    //MARK: - Initializers
    init(image: String, color: UIColor, placeholder: String) {
        super.init(frame: .zero)
        setupTextField(image: image, color: color, placeholder: placeholder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - override funcs
    
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
    private func setupTextField(image: String, color: UIColor, placeholder: String) {
        translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholder
        backgroundColor = .clear
        font = .systemFont(ofSize: 24)
        clearButtonMode = .whileEditing
        layer.cornerRadius = 24

        layer.borderWidth = 1
        layer.borderColor = UIElementsParameters.Color.thirdColor.cgColor
        heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        let image = UIImage(named: image)?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = color
        leftView = imageView
        leftViewMode = .always
        
    }
}
